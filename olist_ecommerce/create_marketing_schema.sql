DROP SCHEMA IF EXISTS marketing CASCADE;
CREATE SCHEMA marketing;

--After a qualified lead fills in a form at a landing page he is contacted by a Sales Development Representative.
--At this step some information is checked and more information about the lead is gathered.
DROP TABLE IF EXISTS marketing.closed_deals CASCADE;
CREATE TABLE marketing.closed_deals
(
    mql_id                        TEXT,                     --Marketing Qualified Lead id
    seller_id                     TEXT,                     --Seller id
    sdr_id                        TEXT,                     --Sales Development Representative id
    sr_id                         TEXT,                     --Sales Representative
    won_date                      TIMESTAMP WITH TIME ZONE, --Date the deal was closed.
    business_segment              TEXT,                     --Lead business segment. Informed on contact.
    lead_type                     TEXT,                     --Lead type. Informed on contact.
    lead_behaviour_profile        TEXT,                     --Lead behaviour profile. SDR identify it on contact
    has_company                   TEXT,                     --Does the lead have a company (formal documentation)?
    has_gtin                      TEXT,                     --Does the lead have Global Trade Item Number (barcode) for his products?
    average_stock                 TEXT,                     --Lead declared average stock. Informed on contact.
    business_type                 TEXT,                     --Type of business (reseller/manufacturer etc.)
    declared_product_catalog_size DOUBLE PRECISION,         --Lead declared catalog size. Informed on contact.
    declared_monthly_revenue      DOUBLE PRECISION          --Lead declared estimated monthly revenue. Informed on contact.
);

--After a lead fills in a form at a landing page, a filter is made to select the ones that are qualified to sell their products at Olist.
--They are the Marketing Qualified Leads (MQLs).
DROP TABLE IF EXISTS marketing.marketing_qualified_leads CASCADE;
CREATE TABLE marketing.marketing_qualified_leads
(
    mql_id             TEXT, --Marketing Qualified Lead id
    first_contact_date DATE, --Date of the first contact solicitation.
    landing_page_id    TEXT, --Landing page id where the lead was acquired
    origin             TEXT  --Type of media where the lead was acquired
);