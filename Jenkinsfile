pipeline {
  agent any
  stages {
    stage('gitclone') {
      steps {
        git 'https://github.com/Mr-Raviteja/apiops-anypoint-bdd-sapi.git'
      }
    }

    stage('maven build') {
      steps {
        withEnv(overrides: ["JAVA_HOME=${ tool 'JDK 8' }", "PATH+MAVEN=${tool 'Maven'}/bin:${env.JAVA_HOME}/bin"]) {
          bat 'mvn -f apiops-anypoint-bdd-sapi/pom.xml clean install -Dtestfile=runner.TestRunner.java -DskipTests'
        }

      }
    }

    stage('Build image') {
      steps {
        script {
          app = docker.build("ravisunny27/apiops-anypoint-bdd-sapi")
        }

        echo 'image built'
      }
    }

    stage('Run container') {
      steps {
        script {
          bat 'docker run -itd -p 8081:8081 ravisunny27/apiops-anypoint-bdd-sapi'
        }

        echo 'container running'
      }
    }

    stage('read properties files') {
      steps {
        script {
          readProps= readProperties file: 'build.properties'
        }

        echo "${readProps['email.to']}"
      }
    }

    stage('Email') {
      steps {
        emailext(subject: 'Testing Reports for $PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', body: 'please go to url: $BUILD_URL.'+readFile("bodyStuff.html"), attachmentsPattern: 'report.html', from: "${readProps['email.from']}", mimeType: 'text/html', to: "${readProps['email.to']}", attachLog: true)
      }
    }

    stage('Kill container') {
      steps {
        script {
          containerId= bat 'docker ps -a -q  --filter ancestor=ravisunny27/apiops-anypoint-bdd-sapi'
          bat 'docker kill ${containerId}'
        }

        echo 'container Killed'
      }
    }

  }
  tools {
    maven 'Maven'
  }
  post {
    failure {
      emailext(subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', body: 'Please find attached logs.', attachLog: true, from: 'test.example.demo123@gmail.com', to: 'raviteja.madishetty@njclabs.com')
    }

  }
}