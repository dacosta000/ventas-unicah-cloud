FROM odoo:20.0

USER root
COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf
RUN mkdir -p /opt/odoo-data && chown -R odoo:odoo /mnt/extra-addons /etc/odoo/odoo.conf /opt/odoo-data

USER odoo
RUN odoo -c /etc/odoo/odoo.conf -d odoo-db-unicah -u web,ventas_unicah --stop-after-init \
    && printf "env['ir.qweb']._get_asset_nodes('web.assets_frontend', css=True, js=True)\nenv['ir.qweb']._get_asset_nodes('web.assets_web', css=True, js=True)\nenv.cr.commit()\n" | odoo shell -c /etc/odoo/odoo.conf -d odoo-db-unicah --no-http

CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]