import * as grpc from '@grpc/grpc-js';
import * as AuthGrpc from '../generated/auth';
import * as AuthService from '../../services/auth.service';
import * as ProfileService from '../../services/profile.service';
import * as ProfileGrpc from '../generated/profile';
import {getProfile} from "../../services/profile.service";

export const callbackError = (callback: grpc.sendUnaryData<any>, err: unknown) => {
  const message = err instanceof Error ? err.message : 'Unknown error';
  callback({code: grpc.status.INTERNAL, message}, null);
};


export const anonymousSignIn = async (
  call: grpc.ServerUnaryCall<AuthGrpc.AnonymousSignInRequest, AuthGrpc.AuthResponse>,
  callback: grpc.sendUnaryData<AuthGrpc.AuthResponse>
) => {
  const { deviceId } = call.request;
  try {
    const result = await AuthService.anonymousSignIn(deviceId);
    callback(null, result);
  } catch (err: any) {
    callback({
      code: grpc.status.INTERNAL,
      message: err.message,
    }, undefined);
  }
};

export const viewProfile = async (
  call: grpc.ServerUnaryCall<ProfileGrpc.ViewRequest, ProfileGrpc.ProfileResponse>,
  callback: grpc.sendUnaryData<ProfileGrpc.ProfileResponse>
) => {
  const { id } = call.request;
  try {
    const result = await ProfileService.getProfile(id);
    callback(null, result);
  } catch (err: any) {
    callback({
      code: grpc.status.INTERNAL,
      message: err.message,
    }, undefined);
  }
};
