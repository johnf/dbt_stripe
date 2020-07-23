

with invoice as (

    select *
    from `dbt-package-testing`.`dbt_kristin_2`.`stg_stripe_invoice`  

), charge as (

    select *
    from `dbt-package-testing`.`dbt_kristin_2`.`stg_stripe_charge`  

), invoice_line_item as (

    select *
    from `dbt-package-testing`.`dbt_kristin_2`.`stg_stripe_invoice_line_item`  

), subscription as (

    select *
    from `dbt-package-testing`.`dbt_kristin_2`.`stg_stripe_subscription`  

), customer as (

    select *
    from `dbt-package-testing`.`dbt_kristin_2`.`stg_stripe_customer`  

)

select 
  invoice.invoice_id,
  invoice.number,
  invoice.created_at as invoice_created_at,
  invoice.status,
  invoice.due_date,
  invoice.amount_due,
  invoice.subtotal,
  invoice.tax,
  invoice.total,
  invoice.amount_paid,
  invoice.amount_remaining,
  invoice.attempt_count,
  invoice.description as invoice_memo,
  invoice_line_item.description as line_item_desc,
  invoice_line_item.amount as line_item_amount,
  invoice_line_item.quantity,
  charge.balance_transaction_id,
  charge.amount as charge_amount, 
  charge.status as charge_status,
  charge.created_at as charge_created_at,
  customer.description as customer_description,
  customer.email as customer_email,
  subscription.subscription_id,
  subscription.billing as subcription_billing,
  subscription.start_date as subscription_start_date,
  subscription.ended_at as subscription_ended_at
from invoice
left join charge on charge.charge_id = invoice.charge_id
left join invoice_line_item on invoice.invoice_id = invoice_line_item.invoice_id
left join subscription on invoice_line_item.subscription_id = subscription.subscription_id
left join customer on invoice.customer_id = customer.customer_id
order by invoice.created_at desc