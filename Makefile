# Makefile for deploying the Flutter web projects to GitHub

# Base URL for Flutter web output
BASE_HREF = /$(OUTPUT)/

# GitHub repo details
GITHUB_USER = kozzmo
GITHUB_REPO = https://github.com/kozzmo/baraddur.git
BUILD_VERSION := $(shell powershell -Command "(Get-Content pubspec.yaml | Select-String '^version:').ToString().Split()[1]")

# Deploy the Flutter web project to GitHub
deploy:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=<output_repo_name>)
endif

	@echo "🧹 Clean existing build"
	flutter clean

	@echo "📦 Getting packages..."
	flutter pub get

	@echo "🛠️  Creating web support files..."
	flutter create . --platform web

	@echo "🏗️  Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "🚀 Deploying to GitHub"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🌍 URL: https://$(GITHUB_USER).github.io/$(OUTPUT)/"

.PHONY: deploy
