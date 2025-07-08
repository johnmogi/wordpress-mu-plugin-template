<?php
/**
 * Plugin Name: Modern MU Plugin
 * Description: A modern WordPress must-use plugin with Composer and PSR-4 autoloading
 * Version: 1.0.0
 * Author: Your Name
 * License: GPL-3.0+
 * Text Domain: modern-mu-plugin
 */

// If this file is called directly, abort.
if (!defined('WPINC')) {
    die;
}

// Define plugin constants
if (!defined('MODERN_MU_PLUGIN_FILE')) {
    define('MODERN_MU_PLUGIN_FILE', __FILE__);
}

if (!defined('MODERN_MU_PLUGIN_PATH')) {
    define('MODERN_MU_PLUGIN_PATH', plugin_dir_path(MODERN_MU_PLUGIN_FILE));
}

if (!defined('MODERN_MU_PLUGIN_URL')) {
    define('MODERN_MU_PLUGIN_URL', plugin_dir_url(MODERN_MU_PLUGIN_FILE));
}

// Check if Composer's autoloader exists
$autoloader = MODERN_MU_PLUGIN_PATH . 'vendor/autoload.php';

if (!file_exists($autoloader)) {
    // Composer autoloader not found
    if (defined('WP_DEBUG') && WP_DEBUG) {
        error_log('Modern MU Plugin: Composer autoloader not found. Run `composer install` in ' . MODERN_MU_PLUGIN_PATH);
    }
    return;
}

// Load Composer autoloader
require_once $autoloader;

// Initialize the plugin
add_action('plugins_loaded', function() {
    // Check if plugin is ready to run
    if (!function_exists('add_action')) {
        return;
    }

    // Initialize the main plugin class
    if (class_exists('\\ModernMU\\Core\\Plugin')) {
        \YourVendor\YourPluginName\Plugin::get_instance();
    }
});
