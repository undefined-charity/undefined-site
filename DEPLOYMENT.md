# Dev Container & GitHub Pages Setup Guide

## 🐳 Dev Container Setup

Your project is now configured with a dev container for consistent development environments.

### Using with VS Code
1. Install the "Dev Containers" extension in VS Code
2. Open the project in VS Code
3. When prompted, click "Reopen in Container" or use `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"
4. The container will build and install dependencies automatically
5. Once ready, run `npm run dev` to start the development server on port 4321

### Using with GitHub Codespaces
1. Go to your GitHub repository
2. Click the green "Code" button
3. Select "Codespaces" tab
4. Click "Create codespace on main"
5. Wait for the environment to set up
6. Run `npm run dev` to start development

### Manual Setup (if not using containers)
```bash
npm install
npm run dev
```

## 🚀 GitHub Pages Deployment

### Initial Setup
1. **Update your astro.config.mjs:**
   ```javascript
   export default defineConfig({
     site: "https://yourusername.github.io", // or your custom domain
     base: "/your-repo-name", // only if deploying to username.github.io/repo-name
     // ... rest of config
   });
   ```

2. **Enable GitHub Pages:**
   - Go to your repository on GitHub
   - Navigate to Settings → Pages
   - Under "Source", select "GitHub Actions"

3. **Push your code:**
   ```bash
   git add .
   git commit -m "Add dev container and GitHub Pages deployment"
   git push origin main
   ```

### Deployment Options

#### Option 1: Deploy to username.github.io (main domain)
- Repository name must be: `yourusername.github.io`
- Set `base: "/"` in astro.config.mjs
- Site will be available at: `https://yourusername.github.io`

#### Option 2: Deploy to a subdirectory
- Repository can have any name (e.g., `my-astro-site`)
- Set `base: "/my-astro-site"` in astro.config.mjs
- Site will be available at: `https://yourusername.github.io/my-astro-site`

#### Option 3: Custom Domain
- Set `site: "https://yourdomain.com"` in astro.config.mjs
- Set `base: "/"` in astro.config.mjs
- Add a CNAME file in the `public` directory with your domain
- Configure DNS to point to GitHub Pages

### Automatic Deployment
The workflow will automatically:
- ✅ Trigger on pushes to the `main` branch
- ✅ Install dependencies
- ✅ Build the Astro site
- ✅ Deploy to GitHub Pages
- ✅ Make your site available at the configured URL

### Manual Deployment
You can also trigger deployment manually:
1. Go to Actions tab in your GitHub repository
2. Select "Deploy to GitHub Pages" workflow
3. Click "Run workflow"

## 🛠️ Development Commands

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Clean build artifacts
npm run clean

# Clean and reinstall dependencies
npm run cleaninstall

# Format code
npm run format
```

## 📝 Notes

- The dev container includes Astro VS Code extension and other helpful tools
- The GitHub Actions workflow uses Node.js 20 for consistency
- Make sure to update the `site` and `base` URLs in astro.config.mjs before deploying
- The build output goes to the `dist` directory
- Search functionality (pagefind) runs automatically after build

## 🔧 Troubleshooting

### Dev Container Issues
- If the container fails to build, try rebuilding: `Ctrl+Shift+P` → "Dev Containers: Rebuild Container"
- Ensure Docker is running on your system

### GitHub Pages Issues
- Check the Actions tab for build errors
- Verify your repository has GitHub Pages enabled
- Make sure the `site` and `base` configuration matches your GitHub Pages setup
- Check that all assets load correctly (images, CSS, JS) after deployment

### Asset Loading Issues
If assets don't load after deployment, verify:
1. Your `base` configuration in astro.config.mjs
2. Image imports use Astro's asset system
3. No hardcoded absolute paths in your components
