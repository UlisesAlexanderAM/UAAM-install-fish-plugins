function install-fish-plugins -d "Install the fish plugins that I use from my local/personal repository"
    
    function __check_if_installed -d "check if the plugin has been already installed from the my local/personal repository, and install it if not"
        set -l plugin $argv[1]
        if pacman -Qi $plugin > /dev/null
            echo "Plugin $plugin already installed"
        else if pacman -Qi $plugin > /dev/null
            sudo pacman -Syu $plugin
        else 
            paru -Syu $plugin
        end
    
    end

    __check_if_installed fish-systemd-git
    __check_if_installed fish-fishtape
    __check_if_installed fish-done
    __check_if_installed fish-abbreviation-tips-git
    #__check_if_installed colored_man_pages.fish
    #__check_if_installed spark.fish

end

