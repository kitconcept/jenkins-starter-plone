#!groovy

pipeline {

  agent master

  environment {
    git_commit_message = ''
    git_commit_diff = ''
    git_commit_author = ''
    git_commit_author_name = ''
    git_commit_author_email = ''
  }

  stages {

    // Build
    stage('Build') {
      agent {
        label 'master'
      }
      steps {
        deleteDir()
        checkout scm
        // Create virtual Python environment
        sh 'virtualenv .'
        // Install setuptools and zc.buildout
        sh 'bin/pip install -r requirements-plone.txt'
        // Build Plone
        sh 'bin/buildout'
        // Create a tar archive with the Plone build
        // (passing around too many files makes the build slow)
        sh 'tar cfz backend.tgz bin develop-eggs include lib parts src *.cfg requirements-plone.txt'
        // Stash the tar archive for later stages
        stash includes: 'backend.tgz', name: 'backend.tgz'
      }
    }

    // Static Code Analysis
    stage('Static Code Analysis') {
      agent {
        label 'master'
      }
      steps {
        deleteDir()
        checkout scm
        sh "echo 'Run Static Code Analysis'"
      }
    }

    // Unit Tests
    stage('Unit Tests') {
      agent {
        label 'master'
      }
      steps {
        deleteDir()
        checkout scm
        sh "echo 'Run Unit Tests'"
      }
    }

    // Acceptance Tests
    stage('Acceptance Tests') {
      agent {
        label 'master'
      }
      steps {
        deleteDir()
        checkout scm
        sh "echo 'Run Acceptance Tests'"
      }
    }

  }
  post {
    success {
      mail to:"me@example.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Yay, we passed."
    }
    failure {
      mail to:"me@example.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Boo, we failed."
    }
  }
}
