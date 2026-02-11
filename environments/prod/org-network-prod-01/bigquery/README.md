# 📊 BigQuery Configuration in GCP

This setup defines the mapping between BigQuery tables and their corresponding datasets within a specific GCP project and location.

---

## 🏗️ Project Information

All BigQuery resources are created under the following project:

```hcl
project_id = "my-project-id"
```

---

## 🌍 Location

BigQuery datasets and tables will be created in the following regional location:

```hcl
location = "us-east4"
```

---

## 🗺️ Table to Dataset Mapping

The configuration uses a mapping between table names and their respective datasets to organize BigQuery resources effectively.

```hcl
id_map = {
  "table1" = "dataset1",
  "table2" = "dataset2"
}
```

This means:
- `table1` will be created in `dataset1`
- `table2` will be created in `dataset2`

---

## ✅ Use Cases

- Structuring data across multiple datasets for security or organizational needs
- Automating BigQuery table creation using infrastructure-as-code tools like Terraform
- Managing BigQuery resources in a centralized and scalable way

---

## 🧩 Integration Notes

Ensure that:
- The datasets exist before creating tables, or include dataset creation logic in your IaC scripts.
- Proper IAM roles are granted to allow BigQuery operations (`roles/bigquery.dataEditor`, `roles/bigquery.jobUser`, etc.)

---

## 📚 References

- [📘 BigQuery Documentation](https://cloud.google.com/bigquery/docs)
- [📘 Terraform Google BigQuery Resources](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table)

---

Keep this file up to date as new tables or datasets are added to the project.