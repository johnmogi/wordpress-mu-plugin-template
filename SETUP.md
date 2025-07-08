# Modern MU Plugin - Setup Instructions

## 🏁 Initial Setup (One-Time)

### 1. Clone the Template
```bash
# Navigate to your mu-plugins directory
cd /path/to/wordpress/wp-content/mu-plugins

# Clone the template
# Option 1: From Git repository
git clone [YOUR_REPO_URL] my-mu-plugin

# Option 2: Copy from local template
git clone ~/path/to/mu-plugin-template my-mu-plugin

# Enter the plugin directory
cd my-mu-plugin
```

### 2. Run the Setup Script

#### Windows (Command Prompt or PowerShell):
```cmd
setup.bat "My Awesome Plugin" "MyVendor"
```

#### Linux/macOS (Bash):
```bash
chmod +x setup.sh
./setup.sh "My Awesome Plugin" "MyVendor"
```

> **Parameters**:
> - First: Plugin Name (e.g., "My Awesome Plugin")
> - Second: Vendor Name (e.g., "MyVendor")

### 3. Install Dependencies
```bash
composer install
```

## 🔄 For Future Projects

1. Copy the entire template directory to a new location
2. Run the setup script with your new plugin details
3. Run `composer install`

## 🛠 Manual Setup (If Script Fails)

1. **Update Namespace** in all PHP files:
   - Replace `YourVendor\\YourPluginName` with `YourVendor\\Core`
   - Update class names in `Plugin.php`

2. **Update composer.json**:
   ```json
   {
     "name": "your-vendor/plugin-name",
     "autoload": {
       "psr-4": {
         "YourVendor\\Core\\": "src/"
       }
     }
   }
   ```

3. **Update mu-plugin.php**:
   - Update plugin header
   - Update namespace references

## ✅ Verification

1. Check that the plugin appears in WordPress admin (if using admin features)
2. Verify no PHP errors in debug.log
3. Test that the autoloader works by creating a test class

## 🔧 Troubleshooting

### Composer Issues
```bash
# If you get memory errors:
COMPOSER_MEMORY_LIMIT=-1 composer install

# If you need to update the autoloader:
composer dump-autoload -o
```

### WordPress Not Loading Plugin
- Ensure the directory is in `wp-content/mu-plugins/`
- Check PHP error logs
- Verify file permissions (755 for directories, 644 for files)

## 📦 Building for Production

```bash
# Install only production dependencies
composer install --no-dev --optimize-autoloader

# Create a deployment package (exclude development files)
zip -r my-mu-plugin.zip . -x "*.git*" "*node_modules*" "*.idea*" "*.vscode*" "*tests*" "*.github*"
```

## 🔗 Helpful Commands

```bash
# Update autoloader after adding new classes
composer dump-autoload -o

# Run tests (if configured)
composer test

# Check for outdated packages
composer outdated
```

## 📞 Support

For issues, please check:
1. The [Troubleshooting](#-troubleshooting) section
2. WordPress debug.log
3. Server error logs

If you still need help, please include:
- PHP version
- WordPress version
- Steps to reproduce the issue
- Any error messages from debug.log
