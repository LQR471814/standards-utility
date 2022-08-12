load("@bazel_gazelle//:def.bzl", "gazelle")
load("@rules_typescript_proto//:index.bzl", "typescript_proto_library")

proto_library(
    name = "proto",
    srcs = [
        glob(["proto/*"]),
    ],
)

typescript_proto_library(
    name = "ts_proto",
    proto = ":proto",
)

# gazelle:prefix server
gazelle(name = "gazelle")
