import jwt from 'jsonwebtoken';

export const generarJWT = ( idUser = 0 ) => {
    return new Promise((resolve, reject) => {
        const payload = { idUser };
        jwt.sign( payload , process.env.SECRETORPRIVATEKEY || '', {
            expiresIn: '1d'
        }, ( err, token ) => {
            if ( err ) {
                console.log(err);
                reject( 'Failed to generate token' );
            } else {
                resolve( token );
            }
        });
    })
}
