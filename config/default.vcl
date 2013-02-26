backend default {
.host = "127.0.0.1";
.port = "8080";
}

acl purge_acl {
  "localhost";
  "127.0.0.1";
}

sub vcl_recv {
  if (req.request == "PURGE" && client.ip ~ purge_acl) {
    ban_url(req.url);
  } else if (req.request == "PURGE") {
    error 405 "You, sir or madam, do not have permission to purrrge here.";
  }
  return (lookup);
}