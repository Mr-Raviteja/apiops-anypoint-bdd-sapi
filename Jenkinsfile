pipeline {
  agent any
  stages {
    stage('gitclone') {
      steps {
        git 'https://github.com/Mr-Raviteja/apiops-anypoint-bdd-sapi.git'
      }
    }

    stage('hello') {
      steps {
        script {
          readProps= readProperties file: 'build.properties'
        }

        echo "${readProps['email.from']}"
      }
    }

    stage('Build') {
      steps {
        withEnv(overrides: ["JAVA_HOME=${ tool 'JDK 8' }", "PATH+MAVEN=${tool 'Maven'}/bin:${env.JAVA_HOME}/bin"]) {
          bat 'mvn -f apiops-anypoint-bdd-sapi/pom.xml clean install'
        }

      }
    }

    stage('Email') {
      steps {
        emailext(subject: 'Testing Reports for $PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', body: 'please go to url: $BUILD_URL.'+readFile("bodyStuff.html"), attachmentsPattern: 'report.html', from: "${readProps['email.from']}", mimeType: 'text/html', to: 'raviteja.madishetty@njclabs.com', attachLog: true)
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