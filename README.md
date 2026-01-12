# KeepCalm <img src="https://cdn.prod.website-files.com/660bc56554d8c22303f02814/693c20f0ba60382ca51d071c_app-icon.png" width="32" alt="KeepCalm logo"/>

**Application d'assistance aux gestes de premiers secours en cas d'arrêt cardiaque.**

En France, le taux de survie lors d'un arrêt cardiaque est de seulement 8%, contre 30% dans les pays où la population est mieux formée aux gestes de premiers secours. KeepCalm propose une alternative : fournir une assistance immédiate et intelligente pour augmenter les chances de survie, sans nécessiter de formation préalable.

![KeepCalm App](https://cdn.prod.website-files.com/660bc56554d8c22303f02814/693c20f0ba60382ca51d071f_KeepCalmApp.png)

---

## Fonctionnalités ⚡

- **Guidage étape par étape** — Instructions claires pour réagir face à une urgence cardiaque
- **Localisation des défibrillateurs** — Carte interactive affichant les DEA à proximité (API GeoDAE)
- **Appel d'urgence intégré** — Lancement direct de l'appel au 15 (SAMU)
- **Assistant IA** — Chatbot pour répondre aux questions en temps réel pendant l'intervention
- **Guide massage cardiaque** — Métronome visuel et audio à 110 bpm pour un rythme efficace
- **Récapitulatif PDF** — Génération automatique d'un résumé de l'intervention pour les secours

---

## Screenshots 📱

<p align="center">
  <img src="https://cdn.prod.website-files.com/660bc56554d8c22303f02814/693c20f0ba60382ca51d0726_tuto-2.png" width="200" alt="Tutoriel"/>
  <img src="https://cdn.prod.website-files.com/660bc56554d8c22303f02814/693c20f0ba60382ca51d072c_intervention-2.png" width="200" alt="Intervention"/>
  <img src="https://cdn.prod.website-files.com/660bc56554d8c22303f02814/693c20f0ba60382ca51d0718_Chatbot-1.png" width="200" alt="Chatbot IA"/>
  <img src="https://cdn.prod.website-files.com/660bc56554d8c22303f02814/693c20f0ba60382ca51d0723_recap-1.png" width="200" alt="Récapitulatif"/>
</p>

---

## Stack technique 🛠

| Back-end | Front-end | APIs & Services |
|----------|-----------|-----------------|
| Ruby 3.3.5 | Stimulus | OpenAI (via ruby_llm) |
| Rails 7.1 | Turbo | Mapbox |
| PostgreSQL | Bootstrap 5 | GeoDAE (défibrillateurs) |
| Devise | SCSS | Cloudinary |

---

## Équipe 👥

Projet réalisé lors du bootcamp [Le Wagon](https://www.lewagon.com/) — Nantes, promotion 2025.

| Nom | Rôle | LinkedIn |
|-----|------|----------|
| **Alexandre Cornuau** | Dev Lead | [LinkedIn](https://www.linkedin.com/in/alexandre-cornuau) |
| Quentin Luylier | Développeur | [LinkedIn](https://www.linkedin.com/in/quentinluylier/) |
| Camille Hemet | Développeuse | [LinkedIn](https://www.linkedin.com/in/camillehemet) |
| Julien Lemaire | Développeur | [LinkedIn](https://www.linkedin.com/in/julien-lemaire-952270382/) |
| Adam Rival | Développeur | [LinkedIn](https://www.linkedin.com/in/adam-rival-3230b633a) |

---

## Contexte 📚

Ce projet a été développé en 2 semaines dans le cadre du projet final du bootcamp Le Wagon (formation Développeur Web). L'objectif était de concevoir une application complète de la conception au déploiement.

[Voir la page projet sur Le Wagon](https://projects.lewagon.com/projects/keepcalm)

---

## Licence

Projet éducatif — Non destiné en l'état à un usage médical professionnel.