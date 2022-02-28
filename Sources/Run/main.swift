import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app)
let corsConfiguration = CORSMiddleware.Configuration(
    allowedOrigin: .all,
    allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
    allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin, HTTPHeaders.Name.init("content"), HTTPHeaders.Name.init("identifier")]
)

let cors = CORSMiddleware(configuration: corsConfiguration)
// cors middleware should come before default error middleware using `at: .beginning`
app.middleware.use(cors, at: .beginning)
app.http.server.configuration.hostname = "127.0.0.1"
app.http.server.configuration.port = 8080
try app.run()
