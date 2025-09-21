# Déploiement Infrastructure GCP avec Terraform

## Vue d'ensemble

Cette infrastructure Terraform déploie une architecture complète sur Google Cloud Platform avec :

- **Cloud Run** : Services containerisés (auth, users, orders)
- **Artifact Registry** : Stockage des images Docker
- **Cloud SQL** : Base de données MySQL privée
- **Cloud Storage** : Bucket pour les données
- **VPC** : Réseau privé avec connectivité sécurisée

## Environnements

- **Development** : `streamquest-dev`
- **Production** : `streamquest-prod`

## Prérequis

### 1. Projets GCP
Créer 2 projets GCP :
```bash
# Dev
gcloud projects create streamquest-dev
gcloud config set project streamquest-dev

# Prod  
gcloud projects create streamquest-prod
gcloud config set project streamquest-prod
```

### 2. Service Accounts
Créer des comptes de service pour GitHub Actions :

```bash
# Pour DEV
gcloud iam service-accounts create github-actions-dev \
  --display-name="GitHub Actions Dev" \
  --description="Service account for GitHub Actions deployment to dev"

gcloud projects add-iam-policy-binding streamquest-dev \
  --member="serviceAccount:github-actions-dev@streamquest-dev.iam.gserviceaccount.com" \
  --role="roles/editor"

gcloud iam service-accounts keys create gcp-sa-dev.json \
  --iam-account=github-actions-dev@streamquest-dev.iam.gserviceaccount.com

# Pour PROD
gcloud iam service-accounts create github-actions-prod \
  --display-name="GitHub Actions Prod" \
  --description="Service account for GitHub Actions deployment to prod"

gcloud projects add-iam-policy-binding streamquest-prod \
  --member="serviceAccount:github-actions-prod@streamquest-prod.iam.gserviceaccount.com" \
  --role="roles/editor"

gcloud iam service-accounts keys create gcp-sa-prod.json \
  --iam-account=github-actions-prod@streamquest-prod.iam.gserviceaccount.com
```

### 3. Secrets GitHub
Ajouter les secrets dans GitHub Repository Settings :

- `GCP_SA_KEY_DEV` : Contenu du fichier `gcp-sa-dev.json`
- `GCP_SA_KEY_PROD` : Contenu du fichier `gcp-sa-prod.json`

**Note**: Le bucket GCS `streamquest-472309-terraform-states` est configuré en dur dans les workflows.

## Structure des Services

```
services/
├── auth/
│   ├── Dockerfile
│   └── src/
├── users/
│   ├── Dockerfile
│   └── src/
└── orders/
    ├── Dockerfile
    └── src/
```

## Déploiement

### Développement (Automatique)
- **Trigger** : Pull Request vers `develop` branch
- **Action** : Plan + Apply automatique sur l'environnement dev
- **État** : Stocké dans GCS avec le préfixe `streamquest/dev`

### Production (Automatique)
- **Trigger** : Publication d'une Release GitHub
- **Action** : Plan + Apply automatique sur l'environnement prod
- **État** : Stocké dans GCS avec le préfixe `streamquest/prod`

## Configuration Backend

Pour utiliser le backend GCS (recommandé en production) :

1. Créer un bucket pour les états Terraform :
```bash
gsutil mb gs://my-terraform-states
```

2. Décommenter le backend dans `backend.tf`

3. Réinitialiser Terraform :
```bash
terraform init -migrate-state
```

## Variables d'Environnement

### Dev (`env/dev.tfvars`)
- `project_id = "streamquest-dev"`
- `env = "dev"`
- `allow_unauthenticated = true`

### Prod (`env/prod.tfvars`)
- `project_id = "streamquest-prod"`
- `env = "prod"`
- `allow_unauthenticated = false`

## Connectivité

### Cloud Run → Cloud SQL
- VPC Connector pour accès privé
- Variables d'environnement : `DB_HOST`, `DB_USER`, `DB_NAME`, `DB_PASSWORD`
- Connexion via socket Unix : `/cloudsql/{connection_name}`

### Réseau
- VPC privé : `10.10.0.0/24`
- VPC Connector : `10.8.0.0/28`
- Cloud SQL en mode privé uniquement

## Monitoring et Logs

- Logs Cloud Run : Console GCP → Cloud Run → Logs
- Logs Cloud SQL : Console GCP → Cloud SQL → Logs
- Monitoring : Cloud Monitoring intégré

## Sécurité

- Cloud SQL accessible uniquement via VPC privé
- Service Accounts avec permissions minimales
- Secrets en variables d'environnement (à migrer vers Secret Manager en prod)

## Coûts Estimés

### Dev (par mois)
- Cloud Run : ~5-10€
- Cloud SQL (db-f1-micro) : ~7€
- Artifact Registry : ~1€
- Storage : ~1€
- **Total : ~15-20€/mois**

### Prod (par mois)
- Cloud Run : ~20-50€
- Cloud SQL (db-n1-standard-1) : ~25€
- Artifact Registry : ~2€
- Storage : ~2€
- **Total : ~50-80€/mois**

## Dépannage

### Erreurs courantes
1. **APIs non activées** : Vérifier que toutes les APIs sont activées
2. **Permissions insuffisantes** : Vérifier les rôles IAM
3. **Réseau** : Vérifier la connectivité VPC
4. **Images** : Vérifier que les images sont poussées dans Artifact Registry

### Commandes utiles
```bash
# Vérifier l'état
terraform plan -var-file=env/dev.tfvars

# Lister les ressources
terraform state list

# Importer une ressource existante
terraform import google_cloud_run_service.svc projects/PROJECT/locations/REGION/services/NAME
```

## Exemple d'application Cloud Run (optionnel)

Un exemple minimal est fourni dans `examples/hello-run` avec un `Dockerfile` et un `server.js` Node.js.

Workflow pour builder/pusher l'image:
```
.github/workflows/example-build.yml
```
Exécution via Run workflow avec `project_id` et `repo_id`. L'image produite pourra être passée en entrée à `Deploy to Development/Production`.
