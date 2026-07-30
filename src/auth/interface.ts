import type { Request } from 'express';

export interface IPayload {
  id: number;
  first_name: string;
  last_name: string;
  email: string;
}

export interface IRequestWithPayload extends Request {
  user: IPayload;
}

export interface IRequestWithPayloadAndRefresh extends IRequestWithPayload {
  refreshToken: string;
}
