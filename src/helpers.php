<?php
/**
 * Helper functions for the Modern MU Plugin.
 *
 * @package YourVendor\YourPluginName
 */

if (!function_exists('modern_mu_plugin_log')) {
    /**
     * Log a message to the WordPress debug log.
     *
     * @param mixed $message Message to log.
     * @param string $level Log level (e.g., 'debug', 'info', 'warning', 'error').
     * @return void
     */
    function modern_mu_plugin_log($message, $level = 'debug') {
        if (!defined('WP_DEBUG') || !WP_DEBUG) {
            return;
        }

        if (is_array($message) || is_object($message)) {
            $message = print_r($message, true);
        }

        error_log(sprintf(
            '[%s] %s: %s',
            current_time('mysql'),
            strtoupper($level),
            $message
        ));
    }
}

if (!function_exists('modern_mu_plugin_get_template')) {
    /**
     * Get a template part.
     *
     * @param string $template_name Template name.
     * @param array  $args          Arguments to pass to the template.
     * @param string $template_path Template path.
     * @param string $default_path  Default path.
     * @return void
     */
    function modern_mu_plugin_get_template($template_name, $args = [], $template_path = '', $default_path = '') {
        if (!empty($args) && is_array($args)) {
            extract($args); // phpcs:ignore WordPress.PHP.DontExtract.extract_extract
        }

        $template = modern_mu_plugin_locate_template($template_name, $template_path, $default_path);

        if (!file_exists($template)) {
            modern_mu_plugin_log(sprintf('Template not found: %s', $template_name), 'error');
            return;
        }

        include $template;
    }
}

if (!function_exists('modern_mu_plugin_locate_template')) {
    /**
     * Locate a template and return the path.
     *
     * @param string $template_name Template name.
     * @param string $template_path Template path.
     * @param string $default_path  Default path.
     * @return string
     */
    function modern_mu_plugin_locate_template($template_name, $template_path = '', $default_path = '') {
        if (!$template_path) {
            $template_path = 'templates/';
        }

        if (!$default_path) {
            $default_path = trailingslashit(MODERN_MU_PLUGIN_PATH) . 'templates/';
        }

        // Look within passed path within the theme - this is priority.
        $template = locate_template([
            trailingslashit($template_path) . $template_name,
            $template_name,
        ]);

        // Get default template
        if (!$template && file_exists(trailingslashit($default_path) . $template_name)) {
            $template = trailingslashit($default_path) . $template_name;
        }

        // Return what we found
        return apply_filters('modern_mu_plugin_locate_template', $template, $template_name, $template_path);
    }
}
