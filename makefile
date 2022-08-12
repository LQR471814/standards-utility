NPX := pnpm exec

PROTO_IN := $(addprefix local/,data.proto generic.proto)
TS_PROTO_OUT := src/proto
GO_PROTO_OUT := server/proto

protobuf:
	$(NPX) protoc -I=proto --ts_out $(TS_PROTO_OUT) $(PROTO_IN)
    protoc -I=proto \
        --go_out=$(GO_PROTO_OUT) \
        --go_opt=paths=source_relative \
        --go-grpc_out=$(GO_PROTO_OUT) \
        --go-grpc_opt=paths=source_relative \
        $(PROTO_IN)

