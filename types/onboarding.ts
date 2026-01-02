export enum OnboardingType {
    ORANGTUA = "ORANGTUA",
    PENDAMPING = "PENDAMPING"
}

export interface OrangTuaOnboardingData {
    usia: string;
    riwayatPenyakit: string[];
    frekuensiOlahraga: string;
    sesakNapas: string;
    tujuanOlahraga: string;
    code: string;
}

export interface PendampingOnboardingData {
    usia: string;
    code: string;
}

export type OnboardingData = OrangTuaOnboardingData | PendampingOnboardingData;
