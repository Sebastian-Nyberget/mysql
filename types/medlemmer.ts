export type Medlem = {
    id: number;
    fornavn: string;
    etternavn: string;
    email: string;
    telefonnummer: string;
    fødselsdato: Date;
    medlemskaps_type: string;
    registrerings_dato: Date;
    aktiv: boolean;
  };