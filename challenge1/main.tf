module "three-tier" {
    source = "./three-tier"

    project = local.project
    region = local.region
    zone = local.zone
    prefix = local.prefix

    app_tier_count = "3"
}