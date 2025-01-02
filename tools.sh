# Install curl and speedtest-cli
echo -e '#!/bin/bash\nsudo apt-get install curl && curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && sudo apt-get install speedtest' > tools.sh && chmod +x tools.sh
