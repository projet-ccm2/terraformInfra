# Terraform Infrastructure

Terraform configuration for deploying infrastructure on Google Cloud Platform.

## Cost Estimation

### Optimized Costs (Current Configuration)

| Environment | Monthly Cost | Savings |
|-------------|--------------|---------|
| **DEV** | ~$7-15 | ~70% |
| **INT** | ~$9-19 | ~75% |
| **PROD** | ~$9-19 | ~75% |
| **Total** | ~$25-53 | ~75% |

### Cost Breakdown (per environment)

- **Cloud SQL (MySQL)** `db-f1-micro`: ~$7-10/month
- **Cloud Storage**: ~$0-2/month (first 5 GB free)
- **Artifact Registry**: ~$0-1/month (first 0.5 GB free)
- **VPC Access Connector**: ~$0-3/month (scale-to-zero)
- **Cloud SQL Backups**: ~$0-3/month (disabled in DEV)
- **VPC Network & APIs**: Free

## Optimizations Applied

1. ✅ **Cloud SQL tier**: Using `db-f1-micro` instead of `db-custom-1-3840` (~$20/month savings)
2. ✅ **VPC Connector**: Scale-to-zero (min_instances = 0) (~$10-15/month savings)
3. ✅ **Backups**: Disabled in DEV, enabled in INT/PROD
4. ✅ **Bucket versioning**: Disabled (~50% storage cost reduction)

## Usage

```bash
# Deploy DEV environment
terraform apply -var-file=env/dev.tfvars

# Deploy INT environment
terraform apply -var-file=env/int.tfvars

# Deploy PROD environment
terraform apply -var-file=env/prod.tfvars
```

## Configuration Files

- `env/dev.tfvars` - Development environment
- `env/int.tfvars` - Integration environment (similar to PROD)
- `env/prod.tfvars` - Production environment

## Resources

- [GCP Pricing Calculator](https://cloud.google.com/products/calculator)
- [Cloud SQL Pricing](https://cloud.google.com/sql/pricing)
- [Cloud Storage Pricing](https://cloud.google.com/storage/pricing)
