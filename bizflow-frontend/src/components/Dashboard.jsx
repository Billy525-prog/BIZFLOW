import { useEffect, useState } from "react";
import axios from "axios";

export default function Dashboard(){

const [products,setProducts] = useState([]);

useEffect(()=>{
axios.get("http://127.0.0.1:8000/api/products")
.then(res=>setProducts(res.data))
},[])

return(
<div style={{padding:"20px"}}>
<h2>Products</h2>

<table border="1" cellPadding="10">
<tr>
<th>Name</th>
<th>Stock</th>
<th>Price</th>
</tr>

{products.map(p=>(
<tr key={p.id}>
<td>{p.name}</td>
<td>{p.quantity}</td>
<td>{p.price}</td>
</tr>
))}
</table>
</div>
)
}
