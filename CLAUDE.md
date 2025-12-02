# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KeepCalm is a Rails 7.1 application for emergency medical intervention guidance. It provides step-by-step instructions for first responders during medical emergencies (e.g., cardiac massage). The app features an intervention tracking system with integrated chat functionality.

## Tech Stack

- Ruby 3.3.5
- Rails 7.1.6
- PostgreSQL
- Hotwire (Turbo + Stimulus)
- Bootstrap 5.3
- Devise for authentication
- Cloudinary for media storage

## Development Commands

### Setup
```bash
bin/setup
bin/rails db:seed
```

### Running the app
```bash
bin/rails server
# or
bin/rails s
```

### Database
```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bin/rails db:reset  # Drop, create, migrate, seed
```

### Testing
```bash
bin/rails test                    # Run all tests
bin/rails test test/models        # Test specific directory
bin/rails test test/models/case_test.rb  # Run single test file
bin/rails test test/models/case_test.rb:10  # Run single test at line
```

### Console
```bash
bin/rails console
# or
bin/rails c
```

## Core Data Model

The application centers around emergency intervention tracking with guided case protocols:

- **User** (Devise): First responder accounts
  - has_many interventions

- **Intervention**: A specific emergency response event
  - belongs_to user, case
  - has_one chat
  - Tracks: address, title, age, start_time, end_time

- **Case**: Emergency protocol template (e.g., "Massage Cardiaque")
  - has_many interventions, steps
  - Contains: name, gif_url for visual demonstration

- **Step**: Individual instruction in a case protocol
  - belongs_to case
  - Types: "information" or "instruction"
  - Fields: step_type, details (HTML allowed), picture_url, number (for ordering)
  - Steps can contain rich HTML content for formatting instructions

- **Chat**: Communication channel for an intervention
  - belongs_to intervention
  - has_many messages

- **Message**: Chat messages
  - belongs_to chat
  - Fields: role, content

## Key Routes

```
root                    -> pages#home
interventions           -> index, show, create
interventions/:id/recap -> recap view
interventions/:id/cases/:id -> nested case view
chats/:id               -> show
chats/:id/messages      -> create
cases                   -> index, show
devise                  -> user authentication
```

## Architecture Notes

### Step Instruction Flow
Cases contain ordered Steps that guide first responders through emergency protocols. Steps use a type system ("information" vs "instruction") and support rich HTML in the `details` field for formatting medical guidance. The GIF URL on Cases provides animated demonstrations.

### Chat Integration
Each Intervention can have one associated Chat for communication during the emergency. Messages track role (presumably for distinguishing between users/system/AI responses).

### Seeds Data
The seeds file (db/seeds.rb) contains sample data for cardiac massage (Massage Cardiaque) case with detailed step-by-step instructions. This provides a reference for the expected data structure and content format.

## Environment Variables

Uses dotenv-rails for environment management. Expected variables:
- Database credentials (production)
- Cloudinary credentials for media uploads
