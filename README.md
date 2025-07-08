# WordPress MU Plugin Template

A modern, production-ready WordPress Must-Use (MU) Plugin template with Composer support, PSR-4 autoloading, and best practices built-in.

## 🚀 Features

- 🏗 **Modern Architecture**: PSR-4 autoloading with Composer
- 🛠 **Easy Setup**: Automated setup scripts for Windows and Unix
- 📦 **Dependency Management**: Built-in Composer support
- 🧪 **Testing Ready**: Pre-configured for PHPUnit
- 🔌 **Extensible**: Modular structure for easy expansion
- 📝 **Comprehensive Documentation**: Includes setup guides and examples
- 🔒 **Secure**: Follows WordPress coding standards and security best practices
- 📝 **Documentation**: Comprehensive guides included
- 🔌 **Extensible**: Modular structure for easy expansion

## 📋 Prerequisites

- PHP 7.4+
- Composer
- WordPress 5.6+

## 🚀 Quick Start

### 1. Create New Plugin

```bash
# Clone this template
cd /path/to/wordpress/wp-content/mu-plugins
git clone https://github.com/johnmogi/wordpress-mu-plugin-template.git my-mu-plugin
cd my-mu-plugin
```

### 2. Run Setup Script

#### Windows:
```cmd
setup.bat "My Awesome Plugin" "MyVendor"
```

#### Linux/macOS:
```bash
chmod +x setup.sh
./setup.sh "My Awesome Plugin" "MyVendor"
```

### 3. Install Dependencies
```bash
composer install
```

## 🏗 Project Structure

```
my-mu-plugin/
├── src/                    # Your plugin's PHP code (PSR-4 autoloaded)
│   ├── Plugin.php         # Main plugin class
│   └── helpers.php        # Helper functions
├── templates/             # Template files (optional)
├── config/                # Configuration files (optional)
├── tests/                 # PHPUnit tests (optional)
├── mu-plugin.php          # Main plugin file
├── composer.json          # Composer configuration
├── setup.sh               # Unix setup script
├── setup.bat              # Windows setup script
└── README.md              # This file
```

## 🛠 Development

### Adding New Functionality

1. Create a new class in `src/`:
   ```php
   // src/Admin/Settings.php
   namespace MyVendor\Core\Admin;
   
   class Settings {
       public function __construct() {
           // Your code here
       }
   }
   ```

2. Register it in `src/Plugin.php`:
   ```php
   private function init_hooks() {
       $this->settings = new Admin\Settings();
   }
   ```

### Using Templates

1. Create template files in `templates/`:
   ```php
   <!-- templates/admin/settings.php -->
   <div class="wrap">
       <h1><?php echo esc_html($title); ?></h1>
       <!-- Your form -->
   </div>
   ```

2. Load the template:
   ```php
   modern_mu_plugin_get_template('admin/settings.php', [
       'title' => 'My Settings'
   ]);
   ```

## 🔍 Debugging

Enable in `wp-config.php`:
```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
```

Usage:
```php
// Simple log
modern_mu_plugin_log('Something happened!');

// With context
modern_mu_plugin_log(['user_id' => 1, 'action' => 'login'], 'info');
```

## 📦 Building for Production

```bash
# Install only production dependencies
composer install --no-dev --optimize-autoloader

# Create deployment package
zip -r my-mu-plugin.zip . -x "*.git*" "*node_modules*" "*.idea*"
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the GPL-3.0-or-later - see the [LICENSE](LICENSE) file for details.

## 📚 Documentation

- [Quick Start Guide](QUICKSTART.md)
- [Detailed Setup Instructions](SETUP.md)

---

Built with ❤️ by [Your Name]
