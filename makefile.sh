# !/bin/bash
# Created by Xiao 
# Usage : please use pro help to see the details
# This is just a simple bash script that automatically generates the cpp file with templates for competitive-programming
# Note that you should change all the path to your own path
# TODO: make it as a command line tool in the future

# {{{ gen
function generate_cp_file {
    # check if the file has already existed
    if [[ -f $1 ]]
    then
        echo "FAILED, ${1} already exists!"
        exit 0
    fi

    # creating the folders
    if [[ $3 != '' ]]
    then
        folders="${@:3}"
        # echo "folders : $folders"
        for char in $folders
        do
            if [[ "$char" =~ [[:space:]] ]]; then
                continue
            fi
            mkdir "$char" 2>/dev/null

            if [ $? -eq 0 ]; then
                echo "Directory '$char' has been created."
            else
                echo "Directory '$char' already exists or couldn't be created."
                exit 1
            fi

            cd $char 

            # creating the file
            if [[ $2 == "cpp" || $2 == "py" ]]
            then
                echo "Successfully create ${1} with templates!"
                touch $1
                if [[ $2 == "cpp" ]]
                then
                    # get the template for competing
                    cat /Users/liam/programming/competitive-programming/script/cpp2.cpp > $1
                fi
                # download the problem test case
                python3 /Users/liam/programming/competitive-programming/script/fetch.py
            else
                echo "Not support language!"
                cd ..
                rm -R $char
            fi

            cd ..

        done
    else
        # check if the file has already existed
        if [[ -f $1 ]]
        then
            echo "FAILED, ${1} already exists!"
            exit 1
        fi

        # creating the file
        if [[ $2 == "cpp" || $2 == "py" ]]
        then
            echo "Successfully create ${1} with templates!"
            touch $1
            cat /Users/liam/programming/competitive-programming/script/cpp.cpp > $1
            # cp /Users/liam/programming/competitive-programming/Script/test.py ./
        else
            echo "Not support language!"
        fi
    fi
} 
# }}}

# {{{ create
function create_file {
    # check if the file has already existed
    if [[ -f $1 ]]
    then
        echo "FAILED, ${1} already exists!"
        exit 1
    fi

    # creating the folders
    Directoties=""
    if [[ $3 != '' ]]
    then
        folders="${@:3}"
        # echo "folders : $folders"
        for char in $folders
        do
            if [[ "$char" =~ [[:space:]] ]]; then
                continue
            fi
            mkdir "$char" 2>/dev/null

            if [ $? -eq 0 ]; then
                echo "Directory '$char' has been created."
                # Directoties="$Directoties$char"
            else
                echo "Directory '$char' already exists or couldn't be created."
                continue
            fi

            cd $char 

            # creating the file
            if [[ $2 == "cpp" || $2 == "py" ]]
            then
                echo "Successfully create ${1} with templates!"
                touch $1
                if [[ $2 == "cpp" ]]
                then
                    cat /Users/liam/programming/competitive-programming/script/cpp2.cpp > $1
                fi

            else
                echo "Not support language!"
                cd ..
                rm -R $char
            fi

            cd ..

        done
        # echo "Created folders: "
        # for ((i = 0; i < ${#Directoties}; i++)); do
        #     char="${Directoties:i:1}"
        #     printf "$char "
        # done
    else
        # check if the file has already existed
        if [[ -f $1 ]]
        then
            echo "FAILED, ${1} already exists!"
            exit 0
        fi

        # creating the file
        if [[ $2 == "cpp" || $2 == "py" ]]
        then
            echo "Successfully create ${1} with templates!"
            touch $1

            if [[ $2 == "cpp" ]]
            then
                cat /Users/liam/programming/competitive-programming/script/cpp2.cpp > $1
            fi
        else
            echo "Not support language!"
        fi
    fi
}

function delete_file {
    if [[ -f $2 ]] 
    then
        echo "Removing ${2} and other cp-related files..."
        rm -R $file_name.dSYM
        rm $2
        rm $file_name.in
        rm $file_name.out
        python3 /Users/liam/programming/competitive-programming/script/dl.py
        rm test.py
    else 
        echo "Oh My dear! There's no $2 file!"
    fi
}
# }}}

function fetch_info {
    echo "Start downloading the problems..."
    python3 /Users/liam/programming/competitive-programming/script/fetch.py
}

function get_dependency {
    echo "Get all the dependencies python files"
    cp /Users/liam/programming/competitive-programming/script/dl.py ./
    cp /Users/liam/programming/competitive-programming/script/fetch.py ./
    cp /Users/liam/programming/competitive-programming/script/test.py ./
}

function display_help {
    echo "Usage: pro <options> <filename> [folders]"
    echo ""
    echo "pro gen <filename> [folders]          generate the cpp/python file with [alias g]"
    echo "pro help                              show the usage [alias h]"
    echo "pro fetch                             fetch the test case information on the ONLINE JUDGE [alias f]"
    echo "pro create <filename> [folders]       simply create the cpp/python file with your own template [alias c]"
    echo "pro delete                            delete all the cp-related files [alias d]"
}

function delete_file {
    cp /Users/liam/programming/competitive-programming/script/dl.py ./
    rm sol
    rm -R sol.dSYM
    python3 dl.py
    rm dl.py
    rm test.py
    rm fetch.py
}

# main 

fileoptions="$1"
filename="$2"
# Extract the file type (extension)
file_type="${filename##*.}"
# Extract the file name (without extension)
file_name="${filename%.*}"

folders="${@:3}"


if [[ $# -eq 0 ]]
then
    display_help
    exit 1
fi

case "$fileoptions" in
    gen | g)
        generate_cp_file $filename $file_type $folders
        ;;
    create | c)
        create_file $filename $file_type $folders
        ;;
    help | h)
        display_help
        ;;
    fetch | f)
        fetch_info
        ;;
    delete | d)
        delete_file
        ;;
    get)
        get_dependency
        ;;
    *)
        echo ""
        echo "Unkonw options: '$fileoptions' "
        display_help
        exit 1
        ;;
esac

exit 0
