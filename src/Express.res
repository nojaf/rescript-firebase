// https://github.com/bloodyowl/rescript-express/blob/main/src/Express.res
type express
@module("express") external express: unit => express = "default"

type method = [#GET | #POST | #PUT | #DELETE | #PATCH]
type request
@get external method: request => method = "method"
@get external headers: request => dict<string> = "headers"
@get external rawBody: request => string = "rawBody"

type response
@send external send: (response, 'a) => response = "send"
@send external sendStatus: (response, int) => response = "sendStatus"
@send external status: (response, int) => response = "status"

type handler = (request, response) => Promise.t<unit>

@send external get: (express, string, handler) => unit = "get"
@send external post: (express, string, handler) => unit = "post"
@send external delete: (express, string, handler) => unit = "delete"
@send external patch: (express, string, handler) => unit = "patch"
@send external put: (express, string, handler) => unit = "put"
@send external all: (express, string, handler) => unit = "all"
