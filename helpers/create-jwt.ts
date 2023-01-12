import jwt from 'jsonwebtoken';

export const generarJWT = ( idUser: number = 0 ) => {
    return new Promise((resolve, reject) => {
        const payload = { idUser };
        jwt.sign( payload , process.env.SECRETORPRIVATEKEY || '', {
            expiresIn: '2d'
        }, ( err, token ) => {
            if ( err ) {
                console.log(err);
                reject( 'No se pudo generar el token' );
            } else {
                resolve( token );
            }
        });
    })
}
