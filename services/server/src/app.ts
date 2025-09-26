import dotenv from 'dotenv';
import { ServerService } from './grpc/generated/server';
import * as grpc from '@grpc/grpc-js';
import * as serverHandler from "./grpc/handlers/server.handler";
// import {initKafka} from "./utils/kafka";
// import config from "./config/config";

dotenv.config();

const server = new grpc.Server();

server.addService(ServerService, {
  health: serverHandler.health,
  status: serverHandler.status,
  livez: serverHandler.livez,
  readyz: serverHandler.readyz,
});

export default server;
