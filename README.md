# Tatoo Connect Social Media App

Tatoo Connect is a fully functional social media app with multiple features built with flutter and dart.

The objective is to permits to Tatoo Artists, Announcers and Evnts organisator to publish their workd ans to Client to see the differents posts, comments them, like them, follow artist and Studio, Events, and choose some Tatoo Flash as we choose a Love Partner to be in contact with the Tatoo Artist.

## Requirements

* Any Operating System (ie. MacOS X, Linux, Windows)
* Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)
* A little knowledge of Dart 3.x and Flutter
* A brain to think

## Features

* Custom photo feed
* Post photo posts from camera or gallery
  * Like posts
  * Comment on posts
    * View all comments on a post
* Search for users
* Realtime Messaging and Sending images
* Deleting Posts
* Profile Pages
  * Change profile picture
  * Change username
  * Follow / Unfollow Users
  * Change image view from grid layout to feed layout
  * Add your own bio
* Notifications Feed showing recent likes / comments of your posts + new followers
* Swipe to delete notification
* Dark Mode Support
* Stories/Status
* Used Provider to manage state

## Screenshots

</p>

## Installation

#### 1. [Setup Flutter](https://flutter.dev/docs/get-started/install)

2. Setup Firebase CLI

#### 3. Setup the firebase app

- You'll need to create a Firebase instance. Follow the instructions
  at https://console.firebase.google.com.
- Once your Firebase instance is created, you'll need to enable Google authentication.

* Go to the Firebase Console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click "Email and Password" and enable it
* You'll need to create a Firestore Database and a Firebase Storage

```
FlutterFire configure and answer to the différents question
```

* The google.service.json and firebase needed diles will be automacality created
* For android, some modifications will be to done in the gradle file (project and app).)
* in the android/build.gradlec:

  ```
  dependencies {
  classpath"org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
  classpath"com.google.gms:google-services:4.4.0"
  }
  ```
* in android/app/build.gradle

```
plugins {  
id"com.android.application"  
id"kotlin-android"  
id"dev.flutter.flutter-gradle-plugin"  
id("com.google.gms.google-services")
}
```

```
dependencies {implementation(platform("com.google.firebase:firebase-bom:32.3.1"))}
applyplugin: 'com.google.gms.google-services'
```

- (skip if not running on iOS)

* Create an app within your Firebase instance for iOS, with your app package name
* Follow instructions to download GoogleService-Info.plist
* Open XCode, right click the Runner folder, select the "Add Files to 'Runner'" menu, and select the
  GoogleService-Info.plist file to add it to /ios/Runner in XCode
* Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item
  in the array value of this key is specific to the Firebase instance. Replace it with the value for
  REVERSED_CLIENT_ID from GoogleService-Info.plist

Double check install instructions for both

- Google Auth Plugin
  - https://pub.dartlang.org/packages/firebase_auth
- Firestore Plugin
  - https://pub.dartlang.org/packages/cloud_firestore

# What's Next?

* [ ] Video Calling
* [ ] Vocal Calling
* [ ] Post multi Media with carousel
* [ ] Sending and Uploading Videos(Video Compatibility)
* [ ] Sending and Uploading Vocal and Audio (AudioCompatibility)
* [ ] Geolocalisation
* [ ] Kind of Users : Tatoo Artist, Event Organisator, Client
* [ ] Choose style page impoved and storage in firebase for Tatoo Artist
* [ ] System of secret key for the licence management (Tatoo Artist, announcers, Event Organisator)
* [ ] Modify feeds page to manage right of posting only from Tatoo Artist, Event Organisator,announcer
* [ ] Tatoo Flash system with Tinder SYstem (swipe card with Super Like to contact the tatoo Artist)
* [ ] Search improvement by Artists, Styles, Geolocalisation, Avalaible Flashes
* [ ] Manage tatoo styles in Profile Page for Tatoo Artist
* [ ] Add Google Auth system
* [ ] Add Meta (Facebook, Instagram) Auth
* [ ] Get the Instagram Post to push on tatoo connect ?
* [ ] Push Tatoo Connect to Instagram Account ?
* [ ] Double Authentication by phone number ?

### Known Issues

# Note

- The stories feature is ready, you can write a cloud scheduler function to auto delete stories
  after 24hrs as cloud functions is not enabled in this project

New Version



# Cahier des charges : Application "Tatoo Connect"

## 1.

Présentation générale

"Tatoo
Connect" est une application Flutter dans sa dernière version, utilisant
Firebase comme backend. C'est un réseau social destiné aux tatoueurs, leurs
clients, aux organisateurs d'événements autour du tatouage, et aux fournisseurs
de matériels de tatouages.

## 2.

Modèle économique

- Gratuit pour les
  Clients
- Payant pour les
  Tatoueurs, les organisateurs d'événements et les fournisseurs
- Système
  d'abonnement annuel avec différents niveaux de prix :

  * Abonnement Tatoueur : le plus cher, accès à
    toutes les fonctionnalités
  * Abonnement Organisateur d'événement : prix
    intermédiaire, création d'événements et de posts
  * Abonnement Fournisseur : le moins cher,
    possibilité de créer des posts pour présenter leurs produits
- Période d'essai
  gratuite d'un mois ou 5 posts sans paiement pour les comptes payants

## 3.

Fonctionnalités principales

### 3.1

Page de Feed

- Similaire à
  Instagram
- Affichage de Posts
  créés par les Tatoueurs, organisateurs d'événements et fournisseurs
- Tous les
  utilisateurs peuvent accéder au Feed, liker un Post, commenter un post, suivre
  un autre Utilisateur
- Présentation des
  Posts sous forme de Card avec :

  * Photo de profil miniature et nom
    d'utilisateur en haut (cliquable pour accéder au profil)
  * Zone d'images/vidéos avec carrousel si
    multiple
  * Fonctionnalités de like (icône cœur),
    commentaire et partage
  * Compteur de likes
  * Possibilité d'afficher les commentaires
    dans un nouvel écran
- Infinite scroll
  pour le chargement des posts

### 3.2

Swipe de Modèles de Tatouage

- Interface
  similaire à Tinder
- Swipe gauche pour
  Disliker, droite pour Liker, bas pour voir les détails, haut pour Super Like
- Seuls les
  Tatoueurs peuvent ajouter des Modèles de tatouage
- Super Like ajoute
  le modèle aux favoris et notifie le Tatoueur
- Possibilité
  d'envoyer un message privé au tatoueur après un Super Like

### 3.3

Système de Chat interne

- Messagerie écrite,
  vocale et vidéo
- Interface
  similaire à WhatsApp/Instagram/Messenger
- Annuaire de
  contacts personnalisable, classé par types (Client, Tatoueur, Organisateur
  d'événement, Fournisseur)
- Recherche de
  contacts, appels vocaux/vidéo, envoi de pièces jointes

### 3.4

Moteur de recherche

- Recherche de
  posts, utilisateurs, modèles de tatouage, produits
- Filtres multiples
  et utilisation de la géolocalisation
- Sauvegarde des
  recherches pour une utilisation ultérieure
- Fonctionnalité
  proche de celle de l'application SeLoger

### 3.5

Profil utilisateur

- Affichage et
  modification des informations personnelles (nom d'utilisateur, photo de profil,
  bio, localisation, genre, type)
- Statistiques
  (nombre de followers, posts, likes)
- Gestion des
  abonnements et blocages
- Fonctionnalités
  spécifiques selon le type d'utilisateur (ex: ajout de modèles pour les
  tatoueurs)
- Liste des posts
  créés avec statistiques (likes, commentaires)
- Option de
  suppression de compte

### 3.6

Gestion des événements

- Création et
  gestion d'événements par les organisateurs
- Participation des
  tatoueurs et fournisseurs aux événements
- Publication
  automatique des événements dans le Feed

### 3.7

Système de paiement

- Création et
  gestion d'événements par les organisateurs
- Informations de
  l'événement : image de présentation, description, lieu (avec carte
  géolocalisée), dates de début et fin, coordonnées de contact
- Possibilité
  d'inviter directement des tatoueurs et fournisseurs via l'application
- Publication
  automatique des événements dans le Feed (republication périodique paramétrable)
- Notification aux
  organisateurs lorsque tatoueurs ou fournisseurs souhaitent participer
- Intégration d'un
  système de paiement pour les abonnements
- Période d'essai
  gratuite pour les comptes payants (1 mois ou 5 posts)
- Gestion des
  changements de type d'utilisateur (ex: passage de Client à Tatoueur)

### 3.8

Gamification

- Système de points
  ou de badges pour encourager l'engagement
- Récompenses pour
  les publications régulières, interactions positives, participation aux
  événements

### 3.9

Réalité augmentée

- Fonctionnalité
  permettant aux clients d'essayer virtuellement un tatouage sur leur peau
- Intégration avec
  la caméra du dispositif

### 3.10

Portfolios pour tatoueurs

- Section dédiée aux
  portfolios des tatoueurs dans leur profil
- Mise en valeur des
  meilleures réalisations
- Galerie
  photo/vidéo personnalisable
- Descriptions
  détaillées des œuvres

### 3.11

Système de réservation

- Prise de
  rendez-vous directe avec les tatoueurs via l'application
- Calendrier intégré
  pour la gestion des disponibilités
- Système de
  confirmation et de rappel automatique

### 3.12

Marketplace

- Section permettant
  aux fournisseurs de vendre leurs produits
- Catalogue de
  produits avec descriptions, prix et disponibilités
- Système de panier
  et de paiement sécurisé
- Suivi des
  commandes et des livraisons

### 3.13

Conseils et tutoriels

- Section éducative
  avec articles et vidéos
- Contenu sur les
  soins post-tatouage, les tendances, les techniques
- Possibilité pour
  les professionnels de contribuer au contenu

### 3.14

Notifications personnalisées

- Système de
  notifications amélioré
- Alertes pour
  nouveaux modèles, événements ou promotions selon les préférences
- Paramètres de
  personnalisation des notifications

### 3.15

Intégration de l'IA

- Suggestion de
  modèles de tatouage basée sur les préférences de l'utilisateur
- Analyse des
  tendances et recommandations personnalisées
- Assistance
  virtuelle pour répondre aux questions fréquentes

### 3.16

Mode hors ligne

- Accès à certaines
  fonctionnalités en mode hors ligne
- Synchronisation
  automatique lors de la reconnexion
- Mise en cache
  intelligente des données fréquemment utilisées

### 3.17

Accessibilité

- Conformité aux
  normes d'accessibilité (WCAG)
- Support pour les
  lecteurs d'écran
- Options de
  contraste élevé et de taille de texte ajustable

### 3.18

Statistiques pour les professionnels

- Tableaux de bord
  détaillés pour tatoueurs et organisateurs d'événements
- Analyses des
  performances (vues, likes, réservations, ventes)
- Rapports
  personnalisables et exportables

### 3.19

Système de parrainage

- Programme de
  parrainage pour encourager les invitations
- Récompenses pour
  le parrain et le filleul
- Suivi des
  parrainages et des récompenses dans le profil utilisateur

### 3.20

Intégration des réseaux sociaux

- Partage facile des
  contenus sur d'autres plateformes sociales (Instagram, Facebook, Twitter, etc.)
- Boutons de partage
  intégrés pour les posts, modèles de tatouage, événements et portfolios
- Option de
  cross-posting automatique pour les professionnels
- Importation de
  contacts depuis les réseaux sociaux

### 3.21

Version légère de l'application

- Version allégée
  pour les appareils avec moins de ressources
- Fonctionnalités de
  base maintenues avec une interface simplifiée
- Optimisation de la
  taille de l'application et de l'utilisation des ressources
- Option de basculer
  entre la version complète et la version légère

## 4.

Interface utilisateur

- TabScreen
  principal avec :

  * AppBar en haut contenant le logo et le nom
    "Tatoo Connect" (cliquable pour accéder à l'écran About)
  * Zone centrale pour le contenu principal
  * TabBar en bas avec icônes pour les
    principales fonctionnalités :

    - Icône Home pour le Feed (visible pour
      tous les utilisateurs)
    - Icône Flash pour la fonctionnalité
      "Tinder" de modèles de tatouage (sauf pour les fournisseurs)
    - Icône "+" pour créer un nouveau
      Post/Story/Événement (selon le type d'utilisateur)
    - Icône Recherche (pour tous les
      utilisateurs)
    - Icône Message pour le chat (pour tous les
      utilisateurs)
    - Icône Profile pour accéder au profil de
      l'utilisateur courant
- Design adaptatif
  pour différentes tailles d'écran
- Thèmes
  personnalisables (clair, sombre, système, personnalisé)
- Intégration fluide
  des nouvelles fonctionnalités dans l'interface existante
- Nouvelle section
  "Marketplace" dans la navigation principale
- Onglet
  "Éducation" pour accéder aux conseils et tutoriels
- Intégration des
  boutons de partage social de manière non intrusive
- Design adaptatif
  pour la version légère, privilégiant la fonctionnalité sur l'esthétique
  complexe

## 5.

Authentification et gestion des comptes

- Page de Login avec
  options Email/Password, Google Sign In, Facebook Sign In
- Création de compte
  avec choix du type d'utilisateur
- Gestion du profil
  (modification, suppression)
- Niveaux d'accès
  différenciés selon le type d'utilisateur (client, tatoueur, fournisseur,
  organisateur)
- Option de
  connexion via les comptes de réseaux sociaux
- Synchronisation
  des profils avec les réseaux sociaux (si l'utilisateur le souhaite)

## 6.

Aspects techniques

- Développement en
  Flutter pour Android, iOS, PWA et web
- Backend Firebase
  (Authentication, Firestore, Storage)
- Architecture
  suivant le pattern Bloc
- 

Internationalisation (possibilité de changer de langue sans redémarrer
l'application)

- Mode hors ligne
  partiel
- Intégration d'un
  système de paiement sécurisé pour la marketplace
- Mise en place d'un
  système de cache pour le mode hors ligne
- Développement
  d'API pour l'intégration de l'IA et des analyses statistiques
- Développement
  d'APIs pour l'intégration avec les principales plateformes de réseaux sociaux
- Optimisation du
  code et des ressources pour la version légère de l'application
- Mise en place d'un
  système de détection automatique des capacités de l'appareil

## 7.

Sécurité et confidentialité

- Gestion sécurisée
  des données utilisateurs
- Options de
  confidentialité pour les profils et les publications
- Conformité au RGPD
  pour la collecte et l'utilisation des données personnelles
- Chiffrement des
  données sensibles, notamment pour les transactions de la marketplace
- Paramètres de
  confidentialité granulaires pour contrôler ce qui est partagé sur les réseaux
  sociaux
- Politique de
  confidentialité mise à jour pour couvrir l'intégration des réseaux sociaux

## 8.

Déploiement et maintenance

- Disponibilité sur
  Google Play Store et Apple App Store
- Mises à jour
  régulières et support utilisateur
- Plan de mise à
  jour régulier pour intégrer progressivement les nouvelles fonctionnalités
- Support technique
  dédié pour les utilisateurs professionnels (tatoueurs, fournisseurs,
  organisateurs)
- Déploiement séparé
  de la version légère sur les stores d'applications
- Stratégie de mise
  à jour pour maintenir la cohérence entre la version complète et la version
  légère

## 9.

Évolutivité et scalabilité

- Architecture
  conçue pour supporter une croissance importante du nombre d'utilisateurs
- Possibilité
  d'ajouter de nouvelles fonctionnalités sans perturber l'existant
- Optimisation
  continue des performances de l'application
- Conception
  modulaire permettant l'activation/désactivation facile des fonctionnalités dans
  la version légère
- Surveillance des
  métriques d'utilisation pour optimiser continuellement les deux versions de
  l'application

## 10.

Marketing et promotion

- Utilisation des
  fonctionnalités de partage social pour augmenter la visibilité de l'application
- Campagnes ciblées
  pour promouvoir la version légère dans les marchés où les appareils à faibles
  ressources sont prédominants
- Programme de
  récompenses pour encourager le partage et l'engagement sur les réseaux sociaux

# Architecture

de base :

Certainement. Voici
une proposition d'architecture idéale pour le projet "Tatoo Connect",
basée sur les dernières versions de Dart et Flutter, ainsi que les meilleures
pratiques de développement :

## 1.

Architecture globale : Clean Architecture + BLoC Pattern

La Clean
Architecture sera utilisée pour séparer les préoccupations et maintenir une
base de code modulaire et testable. Elle sera combinée avec le pattern BLoC
(Business Logic Component) pour la gestion de l'état.

| Couches principales |
| :-----------------: |

a) Presentation
Layer

b) Domain Layer

c) Data Layer

## 2.

Structure des dossiers

```



lib/



├── app/



│   ├── app.dart



│   └── theme/



├── core/



│   ├── error/



│   ├── network/



│   ├── usecases/



│   └── util/



├── data/



│   ├── datasources/



│   ├── models/



│   └── repositories/



├── domain/



│   ├── entities/



│   ├── repositories/



│   └── usecases/



├── presentation/



│   ├── blocs/



│   ├── pages/



│   └── widgets/



└── main.dart



```

## 3.

Gestion des dépendances : GetIt

Utiliser GetIt pour
l'injection de dépendances, facilitant la gestion des instances et améliorant
la testabilité.

## 4.

Navigation : GoRouter

Implémenter GoRouter
pour une gestion efficace de la navigation et des routes nommées.

## 5.

Gestion de l'état : flutter_bloc

Utiliser le package
flutter_bloc pour implémenter le pattern BLoC de manière cohérente dans toute
l'application.

## 6.

Gestion des API : Dio + Retrofit

Combiner Dio pour
les requêtes HTTP avec Retrofit pour générer automatiquement les clients API.

## 7.

Persistence locale : Hive

Utiliser Hive pour
le stockage local, offrant de bonnes performances et une API simple.

## 8.

Internationalisation : easy_localization

Implémenter
easy_localization pour gérer facilement les traductions et le changement de
langue à la volée.

## 9.

Tests

- Unit tests :
  utiliser mockito pour les mocks
- Widget tests :
  tester les widgets isolément
- Integration tests
  : tester les flux complets de l'application

## 10.

CI/CD : Codemagic ou Fastlane

Mettre en place un
pipeline CI/CD pour automatiser les tests, le build et le déploiement.

## 11.

Gestion des assets : flutter_gen

Utiliser flutter_gen
pour générer des classes type-safe pour les assets, réduisant les erreurs liées
aux chemins de fichiers.

## 12.

Logging : logger

Implémenter logger
pour un logging structuré et facile à filtrer.

## 13.

Analytics : Firebase Analytics

Intégrer Firebase
Analytics pour suivre l'utilisation de l'application et les comportements des
utilisateurs.

## 14.

Performance Monitoring : Firebase Performance

Utiliser Firebase
Performance pour surveiller les performances de l'application en production.

## 15.

Gestion des formulaires : reactive_forms

Implémenter
reactive_forms pour une gestion efficace et réactive des formulaires complexes.

## 16.

Animations : rive

Utiliser rive pour
des animations fluides et légères, particulièrement utiles pour la gamification
et l'engagement utilisateur.

## 17.

Réalité augmentée : arkit_plugin (iOS) et arcore_flutter_plugin (Android)

Intégrer ces plugins
pour la fonctionnalité d'essai virtuel de tatouages.

## 18.

Paiements : stripe_flutter

Utiliser
stripe_flutter pour gérer les paiements de manière sécurisée.

Cette architecture
fournit une base solide, modulaire et évolutive pour le projet "Tatoo
Connect". Elle favorise la séparation des préoccupations, la testabilité
et la maintenabilité du code. L'utilisation de packages modernes et bien
maintenus garantit que l'application reste à jour avec les meilleures pratiques
de développement Flutter.

Code et Architecture UI/UX

Interface UI/UX de
"Tatoo Connect" basée sur notre cahier des charges et l'architecture
que nous avons définie. Je vais créer les fichiers principaux pour les écrans
de base, en utilisant une charte graphique inspirée d'Instagram ou Threads.

## Voici

la structure des fichiers pour l'interface UI/UX :

```



lib/



├── app/



│   ├── app.dart



│   └── theme/



│       ├── app_colors.dart



│       ├── app_text_styles.dart



│       └── app_theme.dart



├── presentation/



│   ├── pages/



│   │   ├──
home/



│   │  
│   ├── home_page.dart



│   │  
│   └── widgets/



│   │  
│       ├──
post_card.dart



│   │  
│       └── story_bubble.dart



│   │   ├──
explore/



│   │  
│   ├── explore_page.dart



│   │  
│   └── widgets/



│   │  
│       └── tattoo_swipe_card.dart



│   │   ├──
create_post/



│   │  
│   └── create_post_page.dart



│   │   ├──
chat/



│   │  
│   ├── chat_list_page.dart



│   │  
│   └── chat_detail_page.dart



│   │   ├──
profile/



│   │  
│   ├── profile_page.dart



│   │  
│   └── widgets/



│   │  
│       ├──
profile_header.dart



│   │  
│       └── profile_post_grid.dart



│   │   ├──
auth/



│   │  
│   ├── login_page.dart



│   │  
│   └── register_page.dart



│   │  
└── main_navigation.dart



│   └── widgets/



│       ├── custom_app_bar.dart



│       ├── custom_bottom_nav_bar.dart



│       └── custom_button.dart



└── main.dart



```
