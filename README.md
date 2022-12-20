[![Rails][rails]][rails-url] [![Postman][postman]][postman-url] [![Git][git]][git-url] [![Markdown][markdown]][markdown-url] [![PostgreSQL][postgreSQL]][postgresql-url] [![RSpec][rspec]][rspec-url][![Visual Studio Code][visual studio code]][visual studio code-url]

 <h1>Tea Party</h4>

<div align="center">
<img src="https://user-images.githubusercontent.com/103013480/208700815-97e60cfe-830a-4bf6-9028-186174396dea.png" alt="tea-cup-icon" width="250" /> </div>
Do you love Tea? Well, Tea Party is the place for you! Subscribe to multiple tea subscriptions here! 

The Back End application is an API that exposes endpoints to the Front End for an app that will allow customers to subscribe to different teas. The attributed are set up so that a customer can choose how frequent the expect to recieve their tea the subscribed for.  

<a name="readme-top"></a>

<h2> Table of Contents</h2>
<details open="open">
<summary>Table of Contents</summary>
  <ol>
    <li><a href="#technical-requirements"> Technical Requirements</a></li>
    <li><a href="#gems-and-tools"> Gems and Tools</a></li>
    <li><a href="#installation"> Installation</a></li>
    <li><a href="#schema"> Schema</a></li>
    <li><a href="#endpoints"> API Endpoints</a></li>
    <li><a href="#contributors"> Contributors</a></li>
  </ol>
</details>

<h2 id="technical-requirements">Technical Requirements</h2>
<ul>
<li>Ruby 2.7.4</li>
<li>Rails 5.2.8</li>
</ul>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h2 id="gems-and-tools">Gems and Tools</h2>
<ul>
  <li><a href="https://github.com/pry/pry">Pry</a></li>
  <li><a href="https://github.com/simplecov-ruby/simplecov">SimpleCov</a></li>
  <li><a href="https://github.com/thoughtbot/shoulda-matchers">Shoulda Matchers</a></li>
</ul>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h2 id="installation"> Installation </h2>

To get started, clone the repo in your terminal by entering the following:

<ul>
  <li>git clone git@github.com:Got-Baggage/be_gotbaggage.git</li>
</ul>  
   
Once cloned, run the following commands:
<ul>
  <li>bundle install</li>
  <li>rails db:create</li>
  <li>rails db:migrate</li> 
  <li>rails db:seed</li> 
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h2 id="schema"> Schema</h2>
<img width="487" alt="Database Schema" src="https://user-images.githubusercontent.com/103013480/208704402-39e896d7-ced0-47c8-ac5f-3db35c9ac7b0.png">
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h2 id="endpoints"> Endpoints</h2>
<details open="open">
<summary>Query/Mutation Example Responses</summary>
  <ol>
    <li><a href="#create-customer"> Create Customer</a></li>
    <li><a href="#create-tea">Create Tea</a></li>
    <li><a href="#all-teas">All Teas</a></li>
    <li><a href="#delete-tea">Delete Tea by ID</a></li>
    <li><a href="#subscribe">Tea Subscription</a></li>
    <li><a href="#all-subs">All Subscriptions</a></li>
    <li><a href="#sub-deletes">Delete Subscription by ID</a></li>
  </ol>
</details>

<h4 id="create-customer">Create Customer</h4>

```javascript
enpoint; Post /api/v1/customers
{
  "first_name": "Nikky",
  "last_name": "Ro",
  "address": "1234 Main St. Denver CO",
  "email": "testing123@example.com"
}
```

```javascript
sample response
{
    "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "first_name": "Nikky",
            "last_name": "Ro",
            "address": "1234 Main St. Denver CO",
            "email": "testing123@example.com"
        }
    }
}
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h4 id = "create-tea">Create Tea</h4>

```javascript
enpoint; post /api/v1/teas
{
    "name": "Ginger Tea",
    "description": "Ginger tea is good for motion sickness relief, eleviate nausea, and may help manage blood pressure ",
    "brew_time": 10,
    "temp" : 150
}
```

```javascript
sample response
{
    "data": {
        "id": 2
    },
    "type": "tea",
    "attributes": {
        "name": "Ginger Tea",
        "description": "Ginger tea is good for motion sickness relief, eleviate nausea, and may help manage blood pressure ",
        "temp": 150,
        "brew_time": 10
    }
}
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h4 id = "all-teas">All Teas</h4>

```javascript
enpoint; Get /api/v1/teas

```

```javascript
sample response
{
    "data": [
        {
            "id": 1,
            "type": "tea",
            "attributes": {
                "name": "Manzanilla Tea",
                "description": "Manzanilla (Chamomile Tea) is used for medicinal purposes such as : calming upset stomach, anxiety reducer, sleep improement, cect.",
                "temp": 212,
                "brew_time": 6
            }
        },
        {
            "id": 2,
            "type": "tea",
            "attributes": {
                "name": "Ginger Tea",
                "description": "Ginger tea is good for motion sickness relief, eleviate nausea, and may help manage blood pressure ",
                "temp": 150,
                "brew_time": 10
            }
        }
    ]
}
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h4 id = "delete-tea">Delete Tea by ID</h4>

```javascript
enpoint; Delete /api/v1/teas/:tea_id
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h4 id = "subscribe">Tea Subscription</h4>

```javascript
enpoint; Post api/v1/subscriptions
{
  "title": "Manzanilla subscription",
  "price": 10,
  "status": 1,
  "frequency": 1,
  "tea_id": 1,
  "customer_id": 1
}
```

```javascript
response
{
    "data": {
        "id": 2
    },
    "type": "subscription",
    "attributes": {
        "title": "Manzanilla subscription",
        "price": 10,
        "status": "subscribed",
        "frequency": "weekly"
    }
}
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h4 id = "all-subs">All Subscription</h4>

```javascript
enpoint; Get /api/v1/subscriptions

```

```javascript
response
{
    "data": [
        {
            "id": 1,
            "type": "subscription",
            "attributes": {
                "title": "Manzanilla subscription",
                "price": 10,
                "status": "subscribed",
                "frequency": "weekly"
            }
        },
        {
            "id": 2,
            "type": "subscription",
            "attributes": {
                "title": "Manzanilla subscription",
                "price": 10,
                "status": "subscribed",
                "frequency": "weekly"
            }
        }
    ]
}
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h4 id = "sub-deletes">Delete Subscription by ID</h4>

```javascript
enpoint; Delete /api/v1/subscriptions/:subscription_id 

```
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<h2 id="contributors"> Contributors</h2>



<h3>Nikky Rojas</h3>

[![GitHub Badge](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/nikkyrojas/)
[![LinkedIn Badge](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/nikkyrojas/)


[Rails]: https://camo.githubusercontent.com/1ab1a7ec3f2dd01c7960044047e96a86aed5111004c9b0b86e852eac461bedac/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f527562795f6f6e5f5261696c732d4343303030303f7374796c653d666f722d7468652d6261646765266c6f676f3d727562792d6f6e2d7261696c73266c6f676f436f6c6f723d7768697465
[rails-url]: https://guides.rubyonrails.org/

[Postman]: https://camo.githubusercontent.com/3f0e26b0951bab845a1bb9a7198ecca0da272e462921b6edd85879f3673b6927/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f506f73746d616e2d4646364333373f7374796c653d666f722d7468652d6261646765266c6f676f3d706f73746d616e266c6f676f436f6c6f723d7768697465
[postman-url]: https://www.postman.com/

[Git]: https://user-images.githubusercontent.com/64919819/113648232-81d60d00-9649-11eb-8ea4-0ff5e399afb6.png
[git-url]: https://git-scm.com/doc

[Markdown]: https://camo.githubusercontent.com/510a057988cb5216f5d297ee202f6a08fa179798926cea28e95910f6b8ca5535/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4d61726b646f776e2d3030303030303f7374796c653d666f722d7468652d6261646765266c6f676f3d6d61726b646f776e266c6f676f436f6c6f723d7768697465
[markdown-url]: https://www.markdownguide.org/

[PostgreSQL]: https://camo.githubusercontent.com/281c069a2703e948b536500b9fd808cb4fb2496b3b66741db4013a2c89e91986/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f506f737467726553514c2d3331363139323f7374796c653d666f722d7468652d6261646765266c6f676f3d706f737467726573716c266c6f676f436f6c6f723d7768697465
[postgresql-url]: https://www.postgresql.org/docs/

[RSpec]: https://user-images.githubusercontent.com/64919819/113648167-6965f280-9649-11eb-8794-0f1082ae8d1c.png
[rspec-url]: https://rspec.info/documentation/

[visual studio code]: https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white
[visual studio code-url]: https://code.visualstudio.com/

<p align="right">(<a href="#readme-top">back to top</a>)</p>
