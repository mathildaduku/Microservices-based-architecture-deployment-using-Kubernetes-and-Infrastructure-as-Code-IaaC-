data "kubectl_path_documents" "manifest-files" {
    pattern = "./*.yaml"
}

resource "kubectl_manifest" "monitoring" {
    for_each  = toset(data.kubectl_path_documents.manifest-files.documents)
    yaml_body = each.value
}