# Railway Deployment Guide

This guide explains how to deploy the Flutter Email Marketing & CRM Tool to Railway.

## Prerequisites

- A [Railway](https://railway.app/) account (free tier available)
- Git repository connected to Railway
- Railway CLI (optional, for local testing)

## Deployment Methods

This repository supports two deployment methods:

### Method 1: Docker (Recommended)

The repository includes a `Dockerfile` that:
1. Builds the Flutter web app using the official Flutter Docker image
2. Serves the built app using nginx
3. Includes optimized nginx configuration with caching and compression

**Advantages:**
- Consistent build environment
- Better control over the build process
- Faster subsequent deployments with Docker layer caching

### Method 2: Nixpacks (Alternative)

Railway's automatic builder can also be used with the included `nixpacks.toml` configuration. This uses Python's built-in HTTP server instead of nginx.

**Note:** The Dockerfile method is strongly recommended as it provides:
- Production-grade nginx server with proper configuration
- Better caching and compression
- Security headers
- SPA routing support

**Nixpacks Advantages:**
- Simpler configuration
- No Docker required
- Automatic updates to build tools

**Nixpacks Limitations:**
- Uses Python HTTP server (not production-optimized)
- No advanced caching or compression
- Limited configuration options

## Quick Start

### Option A: Deploy via Railway Dashboard

1. **Sign in to Railway**
   - Go to [railway.app](https://railway.app/)
   - Sign in with GitHub

2. **Create a New Project**
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose `jesscura/fluttersaastool`

3. **Configure Deployment**
   - Railway will automatically detect the `Dockerfile`
   - The app will start building immediately

4. **Access Your App**
   - Once deployed, Railway will provide a URL
   - Your Flutter app will be available at `https://your-app.railway.app`

### Option B: Deploy via Railway CLI

1. **Install Railway CLI**
   ```bash
   npm install -g @railway/cli
   # or
   curl -fsSL https://railway.app/install.sh | sh
   ```

2. **Login to Railway**
   ```bash
   railway login
   ```

3. **Initialize Project**
   ```bash
   cd /path/to/fluttersaastool
   railway init
   ```

4. **Deploy**
   ```bash
   railway up
   ```

5. **Open in Browser**
   ```bash
   railway open
   ```

## Configuration Files

### Dockerfile
- **Location:** `./Dockerfile`
- **Purpose:** Multi-stage build that compiles Flutter web and serves with nginx
- **Port:** 8080 (configurable via Railway's PORT environment variable)

### nginx.conf
- **Location:** `./nginx.conf`
- **Purpose:** Nginx server configuration with:
  - Single Page Application (SPA) routing support
  - Static asset caching
  - Gzip compression
  - Security headers
  - Optimized for Flutter web apps

### railway.json
- **Location:** `./railway.json`
- **Purpose:** Railway-specific configuration including:
  - Build settings (uses Dockerfile)
  - Health check configuration
  - Restart policy

### nixpacks.toml
- **Location:** `./nixpacks.toml`
- **Purpose:** Alternative configuration for Railway's Nixpacks builder
- **Note:** Only used if Dockerfile is not present or if explicitly configured

## Environment Variables

Railway automatically provides:
- `PORT`: The port your app should listen on (default: 8080)

You can add custom environment variables in Railway dashboard:

### Optional Environment Variables

If your app requires additional configuration:

1. Go to your Railway project
2. Click on your service
3. Navigate to "Variables" tab
4. Add variables as needed:
   - `API_URL`: Your backend API URL
   - `SMTP_HOST`: Email server host
   - `SMTP_PORT`: Email server port
   - Other app-specific variables

## Custom Domain

1. In Railway dashboard, go to your service
2. Click "Settings"
3. Scroll to "Domains"
4. Click "Generate Domain" for a railway.app subdomain
5. Or add your custom domain and configure DNS:
   - Add CNAME record: `your-domain.com` → `your-app.railway.app`
   - Railway will automatically provision SSL certificate

## Health Checks

The deployment includes health check configuration:
- **Path:** `/`
- **Timeout:** 100 seconds
- **Type:** HTTP GET request

Railway will automatically restart your service if health checks fail.

## Monitoring

Railway provides built-in monitoring:
- **Logs:** View real-time logs in the dashboard
- **Metrics:** CPU, memory, and network usage
- **Deployments:** Track all deployments and rollbacks

## Troubleshooting

### Build Fails

1. **Check build logs** in Railway dashboard
2. **Common issues:**
   - Flutter dependencies not resolving: Check `pubspec.yaml`
   - Build timeout: Increase build timeout in Railway settings
   - Memory issues: Upgrade to a paid Railway plan for more resources

### App Not Loading

1. **Check deployment logs** for nginx errors
2. **Verify port configuration:** Ensure nginx is listening on port 8080
3. **Check health check status** in Railway dashboard

### Slow Initial Load

Flutter web apps can have a larger initial load size:
- The nginx configuration includes gzip compression to reduce transfer size
- Consider enabling code splitting in future builds
- Use CDN for static assets if needed

## Performance Optimization

### Build Optimization

The Dockerfile uses `--web-renderer html` for better performance:
- Smaller bundle size
- Faster initial load
- Better compatibility with older browsers

For better graphics but larger size, modify the Dockerfile:
```dockerfile
RUN flutter build web --release --web-renderer canvaskit
```

### Caching Strategy

The nginx configuration includes:
- **Static assets** (JS, CSS, images): Cached for 1 year
- **HTML files**: No caching (always fresh)
- **Gzip compression**: Reduces transfer size by ~70%

## Scaling

Railway provides automatic scaling:
- **Horizontal scaling:** Add more instances (paid plans)
- **Vertical scaling:** Increase CPU/memory per instance
- **Auto-scaling:** Configure based on CPU/memory thresholds

## Cost Estimation

Railway pricing:
- **Free tier:** $5 of usage per month (enough for small apps)
- **Paid plans:** Pay-as-you-go, starting at $5/month
- **This app typically uses:** ~$2-5/month on hobby tier

## Rollback

To rollback to a previous deployment:
1. Go to Railway dashboard
2. Click on your service
3. Navigate to "Deployments"
4. Find the previous working deployment
5. Click "Redeploy"

## CI/CD Integration

Railway automatically deploys when you push to your connected branch:

1. **Connect GitHub repo** (done during initial setup)
2. **Configure branch:**
   - Go to Settings → Environment
   - Choose which branch to deploy (e.g., `main`)
3. **Automatic deployments:**
   - Push to branch → Automatic build and deploy
   - Pull requests → Preview deployments (paid plans)

## Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [Nginx Documentation](https://nginx.org/en/docs/)

## Support

For deployment issues:
- Railway Discord: [discord.gg/railway](https://discord.gg/railway)
- GitHub Issues: [github.com/jesscura/fluttersaastool/issues](https://github.com/jesscura/fluttersaastool/issues)
- Railway Documentation: [docs.railway.app](https://docs.railway.app/)

## Security Notes

1. **Never commit secrets** to the repository
2. **Use Railway environment variables** for sensitive data
3. **Keep dependencies updated** for security patches
4. **Enable HTTPS** (automatic with Railway domains)
5. **Review security headers** in nginx.conf

## Next Steps

After deployment:
1. Test all features in production environment
2. Set up monitoring and alerts
3. Configure custom domain (optional)
4. Set up backup strategy for data
5. Document API endpoints and environment variables
6. Set up staging environment for testing
