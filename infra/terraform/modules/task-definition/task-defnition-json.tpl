[
  {
    "name": "${service_name}",
    "image": "${aws_ecr_repo_url}:${docker_image_tag}",
    "cpu": 0,
    "environment": [
      %{ for key, value in environment }
        %{ if key != "CATALINA_OPTS" }
        {
          "name": "${key}",
          "value": "${value}"
        }%{ if key != (keys(environment)[length(environment)-1]) },%{ endif }
        %{ endif }
      %{ endfor }
      %{ if environment.CATALINA_OPTS == "true" }
      ,{
        "name": "CATALINA_OPTS",
        "value": "-Ddb_driver=${environment.db_driver} -Dsso_db_usr=${environment.sso_db_usr} -Dsso_db_pwd=${environment.sso_db_pwd} -Dsso_db_url=${environment.sso_db_url} -Demt_db_usr=${environment.emt_db_usr} -Demt_db_pwd=${environment.emt_db_pwd} -Demt_db_url=${environment.emt_db_url}"
      }
      %{ endif }
    ],
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "${aws_log_group_name}",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "ecs"
      },
      "secretOptions": []
    },
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${container_port}
      }
    ]
  }
]
