import * as ProfileClient from "../grpc/clients/profile.client";

export const getProfile = async (id: string) =>
  await ProfileClient.getProfile(id);

export const health = async () =>
  await ProfileClient.health();

export const status = async () =>
  await ProfileClient.status();

export const livez = async () =>
  await ProfileClient.livez();

export const readyz = async () =>
  await ProfileClient.readyz();

export const view = async (profileId: string) =>
  await ProfileClient.getProfile(profileId);

