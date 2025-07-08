<?php

namespace YourVendor\YourPluginName;

/**
 * Main plugin class.
 */
class Plugin {
    /**
     * The single instance of the class.
     *
     * @var Plugin
     */
    protected static $instance = null;

    /**
     * Main Plugin Instance.
     *
     * Ensures only one instance of the plugin is loaded or can be loaded.
     *
     * @return Plugin - Main instance.
     */
    public static function get_instance() {
        if (is_null(self::$instance)) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Constructor.
     */
    public function __construct() {
        $this->define_constants();
        $this->init_hooks();
    }

    /**
     * Define plugin constants.
     */
    private function define_constants() {
        // Define any plugin-specific constants here
    }

    /**
     * Initialize hooks.
     */
    private function init_hooks() {
        // Example hook
        add_action('init', [$this, 'init']);
        
        // Admin hooks
        if (is_admin()) {
            add_action('admin_init', [$this, 'admin_init']);
            add_action('admin_menu', [$this, 'admin_menu']);
        }
    }

    /**
     * Initialize the plugin.
     */
    public function init() {
        // Initialize plugin functionality here
        do_action('modern_mu_plugin_loaded');
    }

    /**
     * Initialize admin functionality.
     */
    public function admin_init() {
        // Admin initialization code here
    }

    /**
     * Add admin menu items.
     */
    public function admin_menu() {
        // Add admin menu items here
    }
}
