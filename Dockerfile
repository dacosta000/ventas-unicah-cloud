FROM odoo:20.0

USER root
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client && rm -rf /var/lib/apt/lists/*
COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf
RUN chown -R odoo:odoo /mnt/extra-addons /etc/odoo/odoo.conf

USER odoo
CMD ["sh", "-c", "PGPASSWORD=npg_3VBTWwd8yMPb psql -h ep-misty-sound-beo4slkf-pooler.c-9.us-east-2.aws.neon.tech -U odoo-db-unicah_owner -d odoo-db-unicah -c \"DELETE FROM ir_attachment WHERE url LIKE '/web/assets/%';\" || true; exec odoo -c /etc/odoo/odoo.conf -d odoo-db-unicah"]