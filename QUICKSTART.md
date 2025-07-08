# Modern MU Plugin - Quick Start Guide

## 🚀 Getting Started

### Prerequisites
- PHP 7.4+
- Composer
- WordPress 5.6+

### Installation

1. **Clone the template** into your WordPress `mu-plugins` directory:
   ```bash
   git clone [YOUR_TEMPLATE_REPO_URL] wp-content/mu-plugins/my-mu-plugin
   cd wp-content/mu-plugins/my-mu-plugin
   ```

2. **Run the setup script**:
   - **Windows**:
     ```cmd
     setup.bat "My Awesome Plugin" "MyVendor"
     ```
   - **Linux/macOS**:
     ```bash
     chmod +x setup.sh
     ./setup.sh "My Awesome Plugin" "MyVendor"
     ```

3. **Install dependencies**:
   ```bash
   composer install
   ```

## 🏗 Project Structure

```
my-mu-plugin/
├── src/                    # Your plugin's PHP code
│   ├── Plugin.php         # Main plugin class
│   └── helpers.php        # Helper functions
├── templates/             # Template files
├── config/                # Configuration files
├── tests/                 # PHPUnit tests
├── mu-plugin.php          # Main plugin file
├── composer.json          # Composer configuration
└── README.md              # Project documentation
```

## 🛠 Development

### Adding New Functionality

1. **Create a new class**:
   ```php
   // src/Admin/Settings.php
   namespace MyVendor\Core\Admin;
   
   class Settings {
       public function __construct() {
           // Your code here
       }
   }
   ```

2. **Register your class** in `Plugin.php`:
   ```php
   private function init_hooks() {
       // ...
       $this->settings = new Admin\Settings();
   }
   ```

### Using the Template System

1. Create a template file in `templates/`:
   ```php
   <!-- templates/admin/settings-page.php -->
   <div class="wrap">
       <h1><?php echo esc_html(get_admin_page_title()); ?></h1>
       <!-- Your settings form -->
   </div>
   ```

2. Load the template:
   ```php
   modern_mu_plugin_get_template('admin/settings-page.php', [
       'title' => 'My Settings',
       'options' => get_option('my_plugin_options')
   ]);
   ```

## 📦 Building for Production

1. **Install production dependencies**:
   ```bash
   composer install --no-dev --optimize-autoloader
   ```

2. **Create a ZIP archive** (optional):
   ```bash
   # Exclude development files
   zip -r my-mu-plugin.zip . -x "*.git*" "*node_modules*" "*.idea*" "*.vscode*"
   ```

## 🔍 Debugging

Enable debugging in `wp-config.php`:
```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
```

Use the built-in logging:
```php
// Simple message
modern_mu_plugin_log('Something happened!');

// With context
modern_mu_plugin_log(['user_id' => 1, 'action' => 'login'], 'info');
```

## 📚 Advanced Usage

### Adding Dependencies

1. **Add packages** with Composer:
   ```bash
   composer require monolog/monolog
   ```

2. **Use them** in your code:
   ```php
   use Monolog\Logger;
   use Monolog\Handler\StreamHandler;
   
   $log = new Logger('my_logger');
   $log->pushHandler(new StreamHandler('path/to/your.log', Logger::WARNING));
   ```

### Testing

1. **Install test dependencies**:
   ```bash
   composer require --dev phpunit/phpunit
   ```

2. **Run tests**:
   ```bash
   ./vendor/bin/phpunit
   ```

## 🤝 Contributing

1. Create a feature branch
2. Commit your changes
3. Push to the branch
4. Create a new Pull Request

## 📄 License

This project is licensed under the GPL-3.0-or-later - see the [LICENSE](LICENSE) file for details.
