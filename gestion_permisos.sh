#!/bin/bash

# Función para mostrar usuarios
mostrar_usuarios() {
    echo "Usuarios disponibles:"
    cat /etc/passwd | cut -d: -f1
}

# Función para mostrar directorios y subdirectorios
mostrar_directorios() {
    echo "Directorios en la ruta actual:"
    find . -type d
}

# Función para asignar permisos
asignar_permisos() {
    echo "Introduce el nombre del usuario:"
    read usuario
    echo "Introduce la ruta del directorio:"
    read directorio
    echo "Introduce los permisos a asignar (ej: 755):"
    read permisos

    if getent passwd $usuario > /dev/null 2>&1; then
        sudo chown $usuario "$directorio"
        sudo chmod $permisos "$directorio"
        echo "Permisos asignados correctamente a $directorio para el usuario $usuario."
    else
        echo "El usuario $usuario no existe."
    fi
}

# Función para gestionar grupos
gestionar_grupos() {
    echo "1) Crear grupo"
    echo "2) Añadir usuario a grupo"
    echo "3) Cambiar permisos de grupo en directorio"
    echo "4) Volver"
    read -p "Elige una opción: " opcion_grupo

    case $opcion_grupo in
        1)
            read -p "Introduce el nombre del grupo a crear: " nombre_grupo
            sudo groupadd $nombre_grupo
            echo "Grupo '$nombre_grupo' creado."
            ;;
        2)
            read -p "Introduce el nombre del usuario: " nombre_usuario
            read -p "Introduce el nombre del grupo: " nombre_grupo
            sudo usermod -a -G $nombre_grupo $nombre_usuario
            echo "Usuario '$nombre_usuario' añadido al grupo '$nombre_grupo'."
            ;;
        3)
            read -p "Introduce la ruta del directorio: " ruta_directorio
            read -p "Introduce el nombre del grupo: " nombre_grupo
            read -p "Introduce los permisos a asignar (ej: 770): " permisos_grupo
            sudo chown :$nombre_grupo $ruta_directorio
            sudo chmod $permisos_grupo $ruta_directorio
            echo "Permisos '$permisos_grupo' asignados al grupo '$nombre_grupo' en el directorio '$ruta_directorio'."
            ;;
        4)
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
}

# Menú principal
PS3='Selecciona una opción: '
opciones=("Mostrar Usuarios" "Mostrar Directorios" "Asignar Permisos" "Gestionar Grupos" "Salir")
select opt in "${opciones[@]}"
do
    case $opt in
        "Mostrar Usuarios")
            mostrar_usuarios
            ;;
        "Mostrar Directorios")
            mostrar_directorios
            ;;
        "Asignar Permisos")
            asignar_permisos
            ;;
        "Gestionar Grupos")
            gestionar_grupos
            ;;
        "Salir")
            break
            ;;
        *) echo "Opción inválida $REPLY";;
    esac
done