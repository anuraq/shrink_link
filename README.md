# ShrinkLink

**Link Blob to url**

## Run Server
Using mix
```elixir
$ mix run --no-halt
```
with an Interactive Shell
```elixir
$ iex -S mix run --no-halt
```
### This hosts a local server at `localhost:8080`

with endpoints `/, /url, /blob/:blob`

## POST /url
inserts value in database if blob does not exists
```json
{
  "blob" : blob_value,
  "url" : url_value 
}
```
> accepts `json` and `x-www-form-urlencoded`

> if blob is `null` it is assigned a random 5 digit alphanumeric using `nanoid` library.

## GET /blob/:blob
redirects to valid url if `:blob` exits in database