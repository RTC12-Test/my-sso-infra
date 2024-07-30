[
  %{ for container in containers }
  {
    "name": "${container.name}",
    "image": "${container.image}",
    "cpu": 0,
    %{ if lookup(container, "entryPoint", null) != null }
    "entryPoint": ${jsonencode(lookup(container, "entryPoint", null))},
    %{ endif }
    %{ if lookup(container, "dependsOn", null) != null }
    "dependsOn": ${jsonencode(lookup(container, "dependsOn", null))},
    %{ endif }
    %{ if lookup(container, "linuxParameters", null) != null }
    "linuxParameters": ${jsonencode(lookup(container, "linuxParameters", null))},
    %{ endif }
    %{ if lookup(container, "environment", null) != null }
    "environment": [
      %{ for key, value in container.environment }
        {
          "name": "${key}",
          "value": "${value}"
        }%{ if key != (keys(container.environment)[length(container.environment)-1]) },%{ endif }
      %{ endfor }
    ],
    %{ endif }
    %{ if lookup(container, "logConfiguration", null) != null }
    "logConfiguration": {
      "logDriver": "${container.logConfiguration.logDriver}",
      "options": {
        %{ for log_option_key, log_option_value in container.logConfiguration.options }
        "${log_option_key}": "${log_option_value}"%{ if log_option_key != (keys(container.logConfiguration.options)[length(container.logConfiguration.options)-1]) },%{ endif }
        %{ endfor }
      },
      "secretOptions": []
    },
    %{ endif }
    %{ if lookup(container, "portMappings", null) != null }
    "portMappings": ${jsonencode(lookup(container, "portMappings", null))},
    %{ endif }
    %{ if lookup(container, "readonlyRootFilesystem", null) != null }
    "readonlyRootFilesystem": ${jsonencode(lookup(container, "readonlyRootFilesystem", null))},
    %{ endif }  
    %{ if lookup(container, "user", null) != null }
    "user": ${jsonencode(lookup(container, "user", null))},
    %{ endif }      
    %{ if lookup(container, "mountPoints", null) != null }
    "mountPoints": ${jsonencode(lookup(container, "mountPoints", null))},
    %{ endif }
    "essential": ${container.essential}
  }%{ if container != containers[length(containers)-1] },%{ endif }
  %{ endfor }
]
