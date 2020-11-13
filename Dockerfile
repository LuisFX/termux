FROM mcr.microsoft.com/dotnet/sdk:5.0

RUN apt update -y && apt install -y sudo wget curl neofetch bsdtar lsb-release gpg

RUN curl -fsSL https://code-server.dev/install.sh | sh
# VSCode extensions
ENV HOME_DIR "/root"

# Setup User Visual Studio Code Extentions
ENV CODE_SERVER_EXTENSIONS "${HOME_DIR}/.local/share/code-server/extensions"

# Setup User Visual Studio Code Workspace Storage
ENV CODE_SERVER_WORKSPACESTORAGE "${HOME_DIR}/.code-server/User/workspaceStorage"

# Mkdir Workspace Storage
RUN mkdir -p ${CODE_SERVER_WORKSPACESTORAGE}


# Setup C# Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/csharp \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-dotnettools/vsextensions/csharp/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/csharp extension

# Setup Python Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/python \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/python extension

# Setup Ionide-fsharp Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/ionide-fsharp \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-fsharp/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/ionide-fsharp extension

# Setup Ionide-paket Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/ionide-paket \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-Paket/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/ionide-paket extension

# Setup Ionide-FAKE Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/ionide-fake \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ionide/vsextensions/Ionide-FAKE/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/ionide-fake extension

# Setup RainbowCSV Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/rainbow-csv \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/mechatroner/vsextensions/rainbow-csv/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/rainbow-csv extension

# Setup Debugger For Chrome Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/debugger-for-chrome \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/msjsdiag/vsextensions/debugger-for-chrome/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/debugger-for-chrome extension

# Setup Azure Tools Pack Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/azure-tools \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/vscode-node-azure-pack/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/azure-tools extension

# Setup Azure Functions Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/azure-functions \
 && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-azuretools/vsextensions/vscode-azurefunctions/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/azure-functions extension

# Setup Azure Account Extension
RUN mkdir -p ${CODE_SERVER_EXTENSIONS}/azure-account \
 && curl -JLs --retry 5  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/azure-account/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${CODE_SERVER_EXTENSIONS}/azure-account extension

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs | cut -d'.' -f 1)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list' \
 && sudo apt update && sudo apt install azure-functions-core-tools-3

#Install NVM, node and yarn
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install node && npm install -g yarn


EXPOSE 8080
EXPOSE 8085
EXPOSE 8443

ENTRYPOINT [ "code-server", "--auth", "none", "--bind-addr", "0.0.0.0:8443" ]