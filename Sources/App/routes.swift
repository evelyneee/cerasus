import Vapor

let version: PathComponent = PathComponent.init(stringLiteral: "v1")

func routes(_ app: Application) throws {
    app.get { req in
        return try ["message":"hi"].jsonString()
    }

    app.get(version, "playing") { req -> Response in
        let headers = HTTPHeaders([
            ("Authorization", Environment.get("DEV_TOKEN")!),
            ("Media-User-Token", Environment.get("USER_TOKEN")!),
            ("Content-Type","application/json")
        ])
        let request = try await req.client.get(URI.init(string: "https://api.music.apple.com/v1/me/recent/played/tracks"), headers: headers)
        return Response(status: .ok, version: .http2, headers: [:], body: Response.Body(buffer: request.body ?? .init()))
    }
}
