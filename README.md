# scan_network.sh 🖥️📡



## Descripción

`scan_network.sh` es un script de Bash diseñado para escanear una subred en busca de hosts activos. Este script es especialmente útil en situaciones de **pivoting** 🔄, donde es necesario escanear una subred desde una máquina víctima y no se dispone de herramientas como `nmap`. El script utiliza comandos básicos de Bash para realizar pings a los hosts dentro de la subred especificada.

## Requisitos

- Shell Bash 🐚
- Permisos de ejecución en el sistema operativo 🛠️

## Uso

1. **Clona este repositorio** o copia el script en tu máquina.
2. **Otorga permisos de ejecución** al script:
   ```bash
   chmod +x scan_network.sh
   ```
3. **Ejecuta el script** proporcionando una dirección IP dentro de la subred que deseas escanear:
   ```bash
   ./scan_network.sh 192.168.0.2
   ```

## Ejemplo

Para escanear la subred `192.168.0.0/24`, ejecuta el script con una dirección IP dentro de esa subred:

```bash
./scan_network.sh 192.168.0.2
```

El script validará la dirección IP proporcionada y luego escaneará los hosts en la subred `192.168.0.0/24`, informando cuáles están activos.

## Contribución 🤝

Si deseas contribuir a este proyecto, por favor, crea un fork del repositorio, realiza tus cambios y envía un pull request. Tus contribuciones son bienvenidas y apreciadas.

## Licencia 📜

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## 🧑‍💻 Autor

- **1NCO6N1TO** - [GitHub](https://github.com/1NCO6N1TO)
---
