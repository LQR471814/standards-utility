import { proxied } from "@proxy-state/core";
import { persistent } from "@proxy-state/utils";
import { store } from "@proxy-state/svelte";
import { Piece } from "~/proto/local/data";

export const pieces = store(
  persistent("state", proxied<{ [key: string]: Piece }>({}), {
    fromBinary: (value) => Piece.fromBinary(value),
    toBinary: (value) => Piece.toBinary(value),
  })
);

type State = {
  message?: string;
};

export const state = store(proxied<State>({}));
