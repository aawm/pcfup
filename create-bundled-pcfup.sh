#!/bin/bash
set -e

ARCHIVE=$(mktemp)
DESTINATION_FILENAME=pcfup-bundle

tar -czf $ARCHIVE asserts/ commands/ methods/ pcfup

> $DESTINATION_FILENAME

cat >> $DESTINATION_FILENAME <<EOT
#!/bin/bash
SOURCE_ARCHIVE=\$(mktemp)
cat <<EOF | base64 -d > \$SOURCE_ARCHIVE
EOT

base64 $ARCHIVE >> $DESTINATION_FILENAME
rm $ARCHIVE


cat >> $DESTINATION_FILENAME <<EOT
EOF
EXECUTION_FOLDER=\$(mktemp -d)
tar -xf \$SOURCE_ARCHIVE -C \$EXECUTION_FOLDER

. \$EXECUTION_FOLDER/pcfup

rm \$SOURCE_ARCHIVE
rm -rf \$EXECUTION_FOLDER
EOT