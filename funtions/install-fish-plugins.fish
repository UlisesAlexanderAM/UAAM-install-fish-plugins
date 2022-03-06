function install-fish-plugins -d "Install the fish plugins that I use (from AUR or GH)"
    if not command -q git > /dev/null
        echo "Git not installed."
        echo "Installing git..."
        sudo pacman -Syu git
    end
    
    function __check_if_installed -d "check if the plugin has been already installed from the AUR, and install it if not"
        set -l plugin $argv[1]
        if pacman -Qi $plugin > /dev/null
            echo "Plugin $plugin already installed"
        else 
            sudo aura -Akax $plugin
        end
    
    end

    __check_if_installed fish-systemd-git
    __check_if_installed fish-fishtape
    __check_if_installed fish-done
    __check_if_installed fish-abbreviation-tips-git

    set -l srcdir $HOME/Proyectos
    if not test -d $srcdir
        mkdir -pv $srcdir
    end
    
    function __check_project_folder -d "Check if the project folder for the plugin exist"
        set -l project_name $argv[1]
        set -l project_folder $srcdir/$project_name
        if test -d $project_folder
            git -C $project_folder status
        else
            cd $srcdir
            if test $argv[1] = colored_man_pages.fish
                git clone https://github.com/PatrickF1/colored_man_pages.fish.git
            else if test $argv[1] = spark.fish
                git clone https://github.com/jorgebucaran/spark.fish.git
                cp -v $project_folder/completions/* $__fish_config_dir/completions/
            end
            cp -v $project_folder/funtions/* $__fish_config_dir/funtions/
        end
    end

    __check_project_folder colored_man_pages.fish
    __check_project_folder spark.fish

    functions -e __check_if_installed
    functions -e __check_project_folder
    
end

