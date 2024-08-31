[
  %{ for container in containers }
  {
    "name": "${container.name}",
    "image": "${container.image}",
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
    %{ if lookup(container, "secrets", null) != null }
    "secrets": [
      %{ for key, value in container.secrets }
        {
          "name": "${key}",
          "valuefrom": "${value}"
        }%{ if key != (keys(container.secrets)[length(container.secrets)-1]) },%{ endif }
      %{ endfor }
    ],
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
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "${container.name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },    
    "essential": ${container.essential}
  }%{ if container != containers[length(containers)-1] },%{ endif }
  %{ endfor }
]
