-- 1. Top 3 Customers Berdasarkan Jumlah Pesanan
select c.first_name,c.last_name, sum(o.total_amount) as total_order_amount
from customers as c
join orders o
on o.customer_id = c.customer_id
group by c.customer_id
order by total_order_amount desc
LIMIT 3;

-- 2. Rata-Rata Nilai Pesanan per Pelanggan
select c.first_name, c.last_name, avg(o.total_amount) average_order
from customers c
join orders o 
on c.customer_id = o.customer_id
group by c.customer_id;

-- 3. Daftar Karyawan dengan Lebih dari 4 Tiket Support yang Terselesaikan
select e.first_name, e.last_name, count(s.ticket_id)
from employees e
join supporttickets s
on e.employee_id = s.employee_id
where s.status = 'resolved'
group by e.employee_id
having count(s.ticket_id) > 4;

-- 4. Produk yang Belum Pernah Dipesan
select p.product_name
from products p
left join orderdetails od
on od.product_id = p.product_id
where od.order_id is null;

-- 5. Total Pendapatan (Revenue) Perusahaan
select sum(quantity * unit_price)
from orderdetails; 

-- 6. Harga Rata-Rata per Kategori Produk
select category, avg(price)
from products
group by category
having avg(price) > 500;

-- atau

WITH cte_avg_price AS (
    SELECT category, AVG(price) AS rerata
    FROM products
    GROUP BY category
)
SELECT *
FROM cte_avg_price
where rerata > 500;

-- 7. Pelanggan dengan Nilai Pesanan Kumulatif Melebihi 1000
select *
from customers
where customer_id in(
	select customer_id
	from orders
	where total_amount > 1000);
	
