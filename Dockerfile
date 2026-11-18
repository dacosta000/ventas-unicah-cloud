FROM odoo:20.0

USER root
COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf
RUN mkdir -p /opt/odoo-data && chown -R odoo:odoo /mnt/extra-addons /etc/odoo/odoo.conf /opt/odoo-data

USER odoo
RUN odoo -c /etc/odoo/odoo.conf -d odoo-db-unicah -u web,ventas_unicah --stop-after-init \
    && python3 -c "import odoo; odoo.tools.config.parse_config(['-c', '/etc/odoo/odoo.conf', '-d', 'odoo-db-unicah']); registry = odoo.registry('odoo-db-unicah'); \
    with registry.cursor() as cr: \
        env = odoo.api.Environment(cr, 1, {}); \
        env['ir.qweb']._get_asset_nodes('web.assets_frontend', css=True, js=True); \
        env['ir.qweb']._get_asset_nodes('web.assets_web', css=True, js=True); \
        cr.commit()"

CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]