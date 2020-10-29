pipeline {
  agent any
  stages {
    stage('gitclone') {
      steps {
        git 'https://github.com/Mr-Raviteja/apiops-anypoint-bdd-sapi.git'
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